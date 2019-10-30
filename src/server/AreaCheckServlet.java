package server;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Writer;

import static java.lang.Math.abs;

@WebServlet("/check")
public class AreaCheckServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestParser parser = new RequestParser(request);
        ResultsHolder holder = (ResultsHolder) request.getSession().getAttribute("results");
        float x,y,r;
        try {
            x = parser.getX();
            y = parser.getY();
            r = parser.getR();
            if(request.getParameter("Redraw")!= null){
                response.setContentType("text/javascript; charset=UTF-8");
                Writer out = response.getWriter();
                out.write(holder.drawPoints(r));
                out.flush();
                return;
            }
            holder.add(new Result(x, y, r, AreaCheckServlet.inside(x, y, r)));

        }catch (NumberFormatException e){
            try{
                x = parser.getXgraph();
                y = parser.getYgraph();
                r = parser.getR();
                if(request.getParameter("Redraw")!= null){
                    response.setContentType("text/javascript; charset=UTF-8");
                    Writer out = response.getWriter();
                    out.write(holder.drawPoints(r));
                    out.flush();
                    return;
                }
                holder.add(new Result(x, y, r, AreaCheckServlet.inside(x, y, r), false));
            }
            catch (NumberFormatException d){
                holder.add(new Result());
            }
        }
        //System.out.println(holder);
        response.setContentType("application/json; charset=UTF-8");
        Writer out = response.getWriter();
        String razvrat = "{\"htmltxt\":\""+holder.getResults().get(holder.getResults().size()-1).toString()+"\",\n\"Inside\":\"" + ((holder.getResults().get(holder.getResults().size()-1).isCorrect())?(holder.getResults().get(holder.getResults().size()-1).isInside()?"1":"0"):("2")) + "\"}";
        out.write(razvrat);
//        response.sendRedirect("index.jsp");
        //TODO replace this if need
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //TODO replace this if need


    }

    public static boolean inside(float x, float y, float r){
        return x>=0 && y>=0 && x*x+y*y<=r*r  ||
                x>=0 && y<=0 && y >= x-(r/2) ||
                x<=0 && y<=0 && y>=(-r/2) && x >= (-r);
    }
}


class RequestParser{
    private static final float[] ALLOWED_R={2f, 3f, 4f, 5f};

    private HttpServletRequest request;
    private final boolean FROM_FORM;

    public RequestParser(HttpServletRequest request) {
        this.request = request;
        FROM_FORM = request.getParameter("submit_btn")!=null;
    }

    public float getX() throws NumberFormatException{
        float floatX = (float)Float.parseFloat(request.getParameter("x"));
        if(floatX >= -4.0f &&floatX <= 4.0f)
            return floatX;
        throw new NumberFormatException();
    }


    public float getR() throws NumberFormatException{
        float floatR = (float)Float.parseFloat(request.getParameter("r"));
        if(floatR >= 2.0f&& floatR <= 5.0f)
            return floatR;
        throw new NumberFormatException();
    }


    public float getY() throws NumberFormatException{
        float floatY = (float)Float.parseFloat(request.getParameter("y"));
        if (floatY >= -3.0f && floatY <= 3.0f)
            return floatY;

        throw new NumberFormatException();
    }
    public float getXgraph() throws NumberFormatException {
        float floatX = (float)Float.parseFloat(request.getParameter("x"));
        if(floatX >= -6.0f &&floatX <= 6.0f)
            return floatX;
        throw new NumberFormatException();
    }

    public float getYgraph() throws NumberFormatException {
        float floatY = (float)Float.parseFloat(request.getParameter("y"));
        if(floatY >= -6.0f &&floatY <= 6.0f)
            return floatY;
        throw new NumberFormatException();
    }

    public boolean isFROM_FORM() {
        return FROM_FORM;
    }
    public static boolean validX(float x){
        return x*x <= 4.0f * 4.0f;
    }

    public static boolean validY(float y){
        return y*y <= 3.0f * 3.0f;
    }

    public static boolean validR(float r){
        return r <= 5.0f&&r >= 2.0f;
    }
}

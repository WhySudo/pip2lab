package server;

public class Result {
    private float x,y,r;
    private boolean inside;
    private String color;
    private boolean correct;

    public Result(){
        correct=false;
    }

    public Result(float x, float y, float r, boolean inside) {
        correct=true;
        this.x = x;
        this.y = y;
        this.r = r;
        this.inside = inside;
        int key = (int)(r*2);
        if(inside){
            color="#00FF00";
        }
        else{
            color="#FF0000";
        }

    }

    public Result(float x, float y, float r, boolean inside, boolean correct) {
        this(x,y,r,inside);
        this.correct = correct;
    }
    @Override
    public String toString() {
        if (correct) return tdString(x)+ tdString(y)+ tdString(r)+ tdString(inside?"Попал":"Не попал")+"</tr>";
        else {
            StringBuilder razvrat = new StringBuilder("<tr><td colspan='4'><center>Неверные аргументы</center></td></tr><tr><td");
            if(!RequestParser.validX(x)){
                razvrat.append(" class='bad_par'");
            }
            razvrat.append(String.format(">%s</td><td", toStr(x)));
            if(!RequestParser.validY(y)){
                razvrat.append(" class='bad_par'");
            }
            razvrat.append(String.format(">%s</td><td", toStr(y)));
            if(!RequestParser.validR(r)){
                razvrat.append(" class='bad_par'");
            }
            razvrat.append(String.format(">%s</td><td>Не в ОДЗ</td></tr>", toStr(r)));

            return razvrat.toString();
        }
    }

    public String drawPoint(){
        if(correct) {
            String strR = String.format("%.1f", r).replace(",", ".");
            String strX = String.format("%.4f", x ).replace(",", ".");
            String strY = String.format("%.4f", y ).replace(",", ".");
            return String.format("drawPoint(%s,%s,%s,\'%s\');", strR, strX, strY, color);
        }else return "";
    }
    public String drawPoint( float R){
            String strR = String.format("%.1f", R).replace(",", ".");
            String strX = String.format("%.4f", x ).replace(",", ".");
            String strY = String.format("%.4f", y ).replace(",", ".");
            String col = (AreaCheckServlet.inside(x, y, R)?("#00FF00"):("#FF0000"));
            if(correct){
                return String.format("drawPoint(%s,%s,%s,\'%s\');", strR, strX, strY, col);
            }
            else{
                if(x*x <= 6*6 &&y*y<=6*6&& r <=5 && r >= 2)
                {
                    return String.format("drawPoint(%s,%s,%s,\'%s\');", strR, strX, strY, "#AFAFAF");
                }
            }
        return "";
    }
    public String toStr(Object s){
        return s.toString();
    }
    private String tdString(Object s){
        return String.format("<td>%s</td>",s.toString());
    }

    public float getX() {
        return x;
    }

    public float getY() {
        return y;
    }

    public float getR() {
        return r;
    }

    public boolean isInside() {
        return inside;
    }
    public boolean isCorrect(){
        return correct;
    }
}

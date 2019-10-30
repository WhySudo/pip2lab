package server;

import java.util.ArrayList;

public class ResultsHolder {
    private ArrayList<Result> results;

    public ResultsHolder() {
        results=new ArrayList<Result>();
    }

    public ArrayList<Result> getResults() {
        return results;
    }

    public void setResults(ArrayList<Result> results) {
        this.results = results;
    }

    public void add(Result result){
        results.add(result);
    }

    @Override
    public String toString() {
        if(results.size()==0)return "";
        StringBuilder res= new StringBuilder();
        Result[] resArray = new Result[results.size()];
        results.toArray(resArray);
        for(int i=resArray.length-1; i>-1;i--){
            res.append(resArray[i].toString());
        }
        return res.toString();
    }

    public void refresh(){
        results = new ArrayList<Result>();
    }

    public String drawPoints(){
        if(results.size()==0)return "";
        StringBuilder res= new StringBuilder();
        Result[] resArray = new Result[results.size()];
        results.toArray(resArray);
        for(int i=resArray.length-1; i>-1;i--){
            res.append(resArray[i].drawPoint());
        }
        return  res.toString();
    }

    public String drawPoints(float R){
        if(results.size()==0)return "";
        StringBuilder res= new StringBuilder();
        Result[] resArray = new Result[results.size()];
        results.toArray(resArray);
        for(int i=resArray.length-1; i>-1;i--){
            res.append(resArray[i].drawPoint(R));
        }
        return  res.toString();
    }
}

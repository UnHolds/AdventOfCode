import java.io.*;
import java.util.ArrayList;

public class Main {
    public static int loopDepth = 200;

    public static Integer[] solveAoC(ArrayList<Integer> data){
        return forLoop(0, 0, data);
    }

    public static Integer[] forLoop(int depth, int i, ArrayList<Integer> data){

        try{
            int x = 1 / (loopDepth - depth);
        }catch (ArithmeticException e){
            return new Integer[]{0, 0, i};
        }

        int result; int result2 = 0;
        try{
            result = ((data.get(i) - data.get(i+1)) >> 31) & 1;
        }catch (IndexOutOfBoundsException e){
            return new Integer[]{0, 0};
        }

        try{
            result2 = (((data.get(i) + data.get(i + 1)+ data.get(i + 2)) - (data.get(i + 1) + data.get(i + 2)+ data.get(i + 3))) >> 31) & 1;
        }catch (IndexOutOfBoundsException e){}

        Integer[] results = forLoop(depth + 1, i + 1, data);

        try{
            int new_i = results[2];
            try{
                int x = 1 / depth;
                results[0] += result;
                results[1] += result2;
                return results;
            }catch (ArithmeticException e2){
                Integer[] results2 = forLoop(0, new_i, data);
                results[0] += result;
                results[0] += results2[0];
                results[1] += result2;
                results[1] += results2[1];
                return new Integer[]{results[0], results[1]};
            }
        }catch (IndexOutOfBoundsException e){
            results[0] += result;
            results[1] += result2;
            return results;
        }
    }

    public static void getLines(BufferedReader reader, ArrayList<Integer> lines) throws IOException {
        String line = reader.readLine();
        try{
            line.length();
        }catch (NullPointerException e){
            return;
        }
        lines.add(Integer.parseInt(line));
        getLines(reader, lines);
    }

    public static void main(String[] args) throws IOException {
        FileReader fileReader = new FileReader("input.txt");
        BufferedReader bufferedReader = new BufferedReader(fileReader);
        ArrayList<Integer> lines = new ArrayList<>();
        getLines(bufferedReader, lines);
        Integer[] results = solveAoC(lines);
        System.out.println("Solution Day 1 Part 1: " + results[0]);
        System.out.println("Solution Day 1 Part 2: " + results[1]);
    }
}

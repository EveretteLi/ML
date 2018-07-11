package tf_i_df;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.util.TreeMap;

public class test {
    public static void sop(Object x) { System.out.println(x); }
    public static void main(String[] args) {
        File f = new File("testFiles/atest.txt");
        Scanner in = null;
        try{
             in = new Scanner(f);
            while(in.hasNext()) {
                String line = in.nextLine();
                Scanner a = new Scanner(line);
                while(a.hasNext()) {
                    sop(a.next());

                } sop("\n"); a.close();
            }

        } catch(FileNotFoundException e) { System.err.println("file not found");}
        finally {
               in.close();
        }

    }


}

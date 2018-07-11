package tf_i_df;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.*;

/**
 * This is a simple model of how tf -idf algorithm words
 */
public class tf_i_dfModel {
    ArrayList<File> totalFileList;                                          // The list that holes all files
    TreeMap<String, TreeMap<String, Float>> weightTable;                    // The matrix holes all weight of words
    TreeMap<String, HashMap<String, Integer>> wordCounterList;              // A counter for word
    HashMap<String, Integer> wordFrequency;
    int fileCounter;

    public tf_i_dfModel() {
        totalFileList = new ArrayList<>();
        weightTable = new TreeMap<>();
        wordCounterList = new TreeMap<>();
        wordFrequency = new HashMap<>();
        fileCounter = 0;
    }

    //do the math here
    public float tf_i_df(int wordCounter, int totalWords, int fileCounter, int wordFrequency) {
           double wordWeight = ((float)wordCounter/(float)totalWords) *
                   (Math.log((float)fileCounter/(float)wordFrequency));
        return  (float)wordWeight;
    }

    @Override
    public String toString(){
        if(weightTable == null) return "";

        StringBuffer temp = new StringBuffer();
        Set<String> keys = weightTable.keySet();
        for(String fileName : keys){
            temp.append(fileName + "  |  ");
            Set<String> wdKeys = weightTable.get(fileName).keySet();
            for(String each : wdKeys){
                temp.append("   " + each + "  :  " + weightTable.get(fileName).get(each) + "\n");
            }
        }
        return temp.toString();
    }

    public static void sop(Object x){ System.out.println(x); }
    // main
    public static void main(String[] args) {
        tf_i_dfModel myModel = new tf_i_dfModel();
        // initialize totalFileList
        File dir = new File("testFiles");
        File[] files = dir.listFiles();
        for(File each : files)
            myModel.totalFileList.add(each);


        Scanner in;
        HashMap<String, Integer> wordCounter;
        try{
            // iterate though all files
            for(int i = 0; i < myModel.totalFileList.size(); i++) {
                File currentFile = myModel.totalFileList.get(i);
                in = new Scanner(currentFile);
                wordCounter = new HashMap<>();

                // loop through each file
                while(in.hasNext()) {
                    String word = in.next();
                    // if seen -> get that counter and plus one
                    if(wordCounter.keySet().contains(word)){
                        wordCounter.replace(word,
                                wordCounter.get(word)+1);
                    } else {
                        wordCounter.put(word, 1);
                    }
                }
                // collect word counting data, save it in word counter list
                myModel.wordCounterList.put(currentFile.getName(), wordCounter);

                // update word frequency
                Set<String> differentWords = wordCounter.keySet();
                for(String each : differentWords) {
                    if(myModel.wordFrequency.keySet().contains(each)){
                        myModel.wordFrequency.replace(each,
                                myModel.wordFrequency.get(each)+1);
                    } else {
                        myModel.wordFrequency.put(each, 1);
                    }
                }
            }
        } catch(FileNotFoundException e) { System.err.println(e.getMessage());}


        // after collecting data from the files
        // start build table

        // preparing fileCounter
        myModel.fileCounter = myModel.totalFileList.size();

        for(File file : myModel.totalFileList) {
            TreeMap<String, Float> columnHolder = new TreeMap<>();
            HashMap<String, Integer> wordsInFile = myModel.wordCounterList.get(file.getName());
            // preparing totalWords
            int totalWords = 0;
            Set<String> keys = wordsInFile.keySet();
            for(String each : keys){
                totalWords += wordsInFile.get(each);
            }
            // get weight
            for(String each : keys){
                int wordCount = wordsInFile.get(each);
                int wordFrequency = myModel.wordFrequency.get(each);
                float weight = myModel.tf_i_df(wordCount, totalWords, myModel.fileCounter, wordFrequency);
                columnHolder.put(each, weight);
            }
            // build table
            myModel.weightTable.put(file.getName(), columnHolder);
        }


        //Testing
        sop(myModel.toString());


    }
}



























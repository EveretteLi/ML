
import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;
import java.util.Set;
import java.util.TreeMap;

/**
 * This is a simple model of how tf-idf algorithm works.
 * This algorithm will treats each line as a document
 * and calculates the weight for each word based on this assumption.
 */
public class Tf_idfExplain {
    ArrayList<ArrayList<String>> allDocuments;                          // store all documents that we care about.
    ArrayList<TreeMap<String, Float>> tfLists;                          // each tfList holes the tf for one document.
    ArrayList<TreeMap<String, Integer>> wordCountLists;                 // each wordCount holes the word count for one document.
    TreeMap<String, Float> idfList;                                     // the list holes the idf of all words in all documents.
    ArrayList<TreeMap<String, Float>> weightMatrix;                     // the final weight matrix;

    /**
     * This constructor will take the "oriDocument" file and treats each line inside as a document to run the tf_idf algorithm
     * @param oriDocument the original file that we put in.
     */
    public Tf_idfExplain(File oriDocument) {
        allDocuments = new ArrayList<>();
        tfLists = new ArrayList<>();
        wordCountLists = new ArrayList<>();
        idfList = new TreeMap<>();
        weightMatrix = new ArrayList<>();

        // treats each line as a document
        Scanner in = null;
        try{
            in = new Scanner(oriDocument);
            ArrayList<String> documentHolder = new ArrayList<>();
            while(in.hasNext()) {
                String line = in.nextLine();
                Scanner word = new Scanner(line);
                while(word.hasNext()) {
                    documentHolder.add(word.next());
                } word.close();
                allDocuments.add(documentHolder); documentHolder = new ArrayList<>();
            }
        } catch (FileNotFoundException e) {System.err.println(e.getMessage());}
        finally {
            in.close();
        }


        /* by now all the document should be collected */
    }

    /**
     * This function adds document into the whole document collection that we care about
     * @param newDocument the new document that has been added
     * @return true if the document has been successfully added.
     */
    public boolean addDocuments(ArrayList<String> newDocument) {
        return allDocuments.add(newDocument);
    }


    /**
     * This function multiply the Term Frequency and the inverse of Document Frequency
     * to get a final weight for the word.
     * (term frequency) * (document frequency)
     * @return the final weight that marks how significance a word is to a document.
     */
    public void tf_idf() {
        TreeMap<String, Float> tempHolder = new TreeMap<>();
        // i will representing the index of document
        for(int i = 0; i < tfLists.size(); i++) {
            TreeMap<String, Float> temp;
            temp = tfLists.get(i);
            // get term frequency of all words in each document
            Set<String> keys = temp.keySet();
            for(String each : keys) {
                float tf = temp.get(each);                          // term frequency of this word
                float idf = idfList.get(each);                      // document frequency of this word
                float weight = tf * (float) Math.log(idf);          // balance it
                tempHolder.put(each, weight);                       // store the outcome (word, weight)
            }
            weightMatrix.add(tempHolder); tempHolder = new TreeMap<>();
        }


        /* by now all word should be mapped to it's weight in the weightMatrix,
         where the index of the ArrayList representing the row of the matrix(document) and TreeMap representing the column
         of it(word pairs with weight)
          */
    }

    /**
     * this funciton will print the weight matrix
     * @return the weight matrix, where document is represented by row and word is by column.
     */
    @Override
    public String toString() {
        ArrayList<String> allWords = new ArrayList<>();
        for(int i = 0; i < weightMatrix.size(); i++) {
            Set<String> words = wordCountLists.get(i).keySet();
            for(String each : words) {
                if(!allWords.contains(each)) { allWords.add(each); }
                else continue;
            }
        }


        StringBuffer p = new StringBuffer("");
        for(int i = 0; i < weightMatrix.size(); i++) {
            p.append((i+1) + "  |   ");
            TreeMap<String, Float> weightHolder = weightMatrix.get(i);
            for(String each : allWords) {
                // if contains print the wight else just print 0
                if(weightHolder.keySet().contains(each)) { p.append(each + ":  " + weightHolder.get(each) + "|    "); }
                else { p.append(each + "  :  " + 0 + "|    "); }
            }
            p.append("\n");
        }
        return p.toString();
    }

    /**
     * read all the document and initialized the word count list.
     */
    public void readDoc() {
        TreeMap<String, Integer> countHolder = new TreeMap<>();
        for(int i = 0; i < allDocuments.size(); i++) {
            ArrayList<String> doc = allDocuments.get(i);

            // assigning one doc
            for(String each : doc) {

                // put word into list of it's a new one
                if(!countHolder.keySet().contains(each)) countHolder.put(each, 1);
                // if seen -> increase the counter
                else{ countHolder.replace(each, countHolder.get(each)+1); }
            }

            //add this tree map into wordCounterList
            wordCountLists.add(countHolder);
            countHolder = new TreeMap<>();
        }

        /* by now wordCounterList should contains word count for all words in it's document */
    }

    /**
     * term frequency describes how often does a word shows in a document.
     * here I use the number of word divides the total words in that document.
     * (number of word) / (total word in the document which holes that word)
     */
    public void term_frequency() {

        TreeMap<String, Float> tfHolder = new TreeMap<>();

        // get the word count list then generate a term frequency list according to it
        for(int i = 0; i < wordCountLists.size(); i++) {
            TreeMap<String, Integer> wordCounter = wordCountLists.get(i);
            int totalWords = allDocuments.get(i).size();

            // calculates term frequency for each word
            Set<String> keys = wordCounter.keySet();
            for(String each : keys) {

                // term_frequency !!
                float term_frequency = (float) wordCounter.get(each) / (float) totalWords;
                tfHolder.put(each, term_frequency);
            }
            // put tfHolder into the tfList
            tfLists.add(tfHolder); tfHolder = new TreeMap<>();
        }

        /* by now the tfLists should be fulled with the lists of term frequency of each document */
    }

    /**
     * inverse of document frequency shows how common this word is through out the documents
     * the more common this word is the less important this word would be to a single document.
     */
    public void inverse_document_frequency() {
        TreeMap<String, Float> dfHolder = new TreeMap<>();
        for(int i = 0; i < wordCountLists.size(); i++) {
            Set<String> keys = wordCountLists.get(i).keySet();
            for(String each : keys) {
                if (!dfHolder.keySet().contains(each)) { dfHolder.put(each, (float)1); }
                else { dfHolder.replace(each, dfHolder.get(each) + 1); }
            }
        }

        // inverse_document_frequency !!
        Set<String> keys = dfHolder.keySet();
        float numberOfDocument = allDocuments.size();
        for(String each : keys) {
            float document_frequency = numberOfDocument / dfHolder.get(each);
            idfList.put(each, document_frequency);
        }

        // by now the dfLists should contains all inverse document frequency mapping with words.
    }


    public static void sop(Object x) { System.out.println(x); }
    public static void main(String[] args) {
        File oriFile = new File("testFiles/atest.txt");
        Tf_idfExplain t = new Tf_idfExplain(oriFile);
        t.readDoc();
        t.term_frequency();
        t.inverse_document_frequency();
        t.tf_idf();
        sop(t.toString());
        //sop(t.weightMatrix);
        sop(t.allDocuments);

    }
}

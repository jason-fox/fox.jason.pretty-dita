/*
 *  This file is part of the DITA-OT Pretty DITA Plug-in project.
 *  See the accompanying LICENSE file for applicable licenses.
 */

package fox.jason.prettydita.tasks;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.regex.Pattern;
import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.Task;
import org.apache.tools.ant.taskdefs.Echo;
import org.apache.tools.ant.util.FileUtils;

//
//    Entry point to the tidier function which  standardizes
//    Whitespace across the file
//

public class PrettyDitaTask extends Task {
  /**
   * Field file.
   */
  private String file;
  /**
   * Field indentStyle.
   */
  private char indentStyle;

  /**
   * Field pragma.
   */
  private boolean hasPragma;

  /**
   * Field addPragma.
   */
  private boolean addPragma;

  /**
   * Field printWidth.
   */
  private int printWidth;

  /**
   * Creates a new <code>PrettyDitaTask</code> instance.
   */
  public PrettyDitaTask() {
    super();
    this.hasPragma = false;
    this.file = null;
    this.indentStyle = ' ';
    this.printWidth = 80;
    this.addPragma = false;
  }

  /**
   * Method setpragma.
   *
   * @param pragma String
   */
  public void setPragma(String pragma) {
    this.hasPragma = Boolean.parseBoolean(pragma);
  }

  /**
   * Method setFile.
   *
   * @param file String
   */
  public void setFile(String file) {
    this.file = file;
  }

  // Standard Doctype replacements
  private String getDoctype(String doctype) {
    String type = null;

    switch (doctype.toLowerCase()) {
      case "concept":
        type = "PUBLIC \"-//OASIS//DTD DITA Concept//EN\" \"concept.dtd\"";
        break;
      case "ditabase":
        type = "PUBLIC \"-//OASIS//DTD DITA Composite//EN\" \"ditabase.dtd\"";
        break;
      case "glossentry":
        type =
          "PUBLIC \"-//OASIS//DTD DITA Glossary Entry//EN\" \"glossentry.dtd\"";
        break;
      case "glossary":
        type = "PUBLIC \"-//OASIS//DTD DITA Glossary//EN\" \"glossary.dtd\"";
        break;
      case "reference":
        type = "PUBLIC \"-//OASIS//DTD DITA Reference//EN\" \"reference.dtd\"";
        break;
      case "task":
        type = "PUBLIC \"-//OASIS//DTD DITA Task//EN\" \"task.dtd\"";
        break;
      case "generaltask":
        type =
          "PUBLIC \"-//OASIS//DTD DITA General Task//EN\" \"generalTask.dtd\"";
        break;
      case "topic":
        type = "PUBLIC \"-//OASIS//DTD DITA Topic//EN\" \"topic.dtd\"";
        break;
      case "basetopic":
        type = "PUBLIC \"-//OASIS//DTD DITA Base Topic//EN\" \"basetopic.dtd\"";
        break;
      case "machinerytask":
        type =
          "PUBLIC \"-//OASIS//DTD DITA Machinery Task//EN\" \"machineryTask.dtd\"";
        break;
      case "learningassessment":
        type =
          "PUBLIC \"-//OASIS//DTD DITA Learning Assessment//EN\" \"learningAssessment.dtd\"";
        break;
      case "learningcontent":
        type =
          "PUBLIC \"-//OASIS//DTD DITA Learning Content//EN\" \"learningContent.dtd\"";
        break;
      case "learningoverview":
        type =
          "PUBLIC \"-//OASIS//DTD DITA Learning Overview//EN\" \"learningOverview.dtd\"";
        break;
      case "learningplan":
        type =
          "PUBLIC \"-//OASIS//DTD DITA Learning Plan//EN\" \"learningPlan.dtd\"";
        break;
      case "learningsummary":
        type =
          "PUBLIC \"-//OASIS//DTD DITA Learning Summary//EN\" \"learningSummary.dtd\"";
        break;
      case "map":
        type = "PUBLIC \"-//OASIS//DTD DITA Map//EN\" \"map.dtd\"";
        break;
      case "basemap":
        type = "PUBLIC \"-//OASIS//DTD DITA Base Map//EN\" \"basemap.dtd\"";
        break;
      case "bookmap":
        type = "PUBLIC \"-//OASIS//DTD DITA BookMap//EN\" \"bookmap.dtd\"";
        break;
      case "subjectscheme":
        type =
          "PUBLIC \"-//OASIS//DTD DITA Subject Scheme Map//EN\" \"subjectScheme.dtd\"";
        break;
      case "classifymap":
        type =
          "PUBLIC \"-//OASIS//DTD DITA Classification Map//EN\" \"classifyMap.dtd\"";
        break;
      case "learningbookmap":
        type =
          "PUBLIC \"-//OASIS//DTD DITA Learning BookMap//EN\" \"learningBookmap.dtd\"";
        break;
      case "learningmap":
        type =
          "PUBLIC \"-//OASIS//DTD DITA Learning Map//EN\" \"learningMap.dtd\"";
        break;
      case "ditaval":
        type = "PUBLIC \"-//OASIS//DTD DITA DITAVAL//EN\" \"ditaval.dtd\"";
        break;
    }
    return type;
  }

  // For a text element which should run over multiple
  // lines, expand and indent the text
  private String splitText(List<String> str, int indentSize) {
    String text = String.join(" ", str);
    int split = 0;
    List<String> arr = new ArrayList<>();
    char[] charArray = new char[indentSize];
    Arrays.fill(charArray, this.indentStyle);
    String spaces = new String(charArray);

    while (split > -1) {
      split = splitAtSpace(text);

      if (split != -1) {
        arr.add(text.substring(0, split));
        text = text.substring(split);
      } else if (!arr.isEmpty()) {
        arr.set(arr.size() - 1, arr.get(arr.size() - 1) + text);
      } else {
        arr.add(text);
      }
    }

    return spaces + " " + String.join("\n" + spaces, arr);
  }

  // Find the nearest space to the preferred printWidth
  // but don't break up  inline tags unless absolutely
  // necessary.
  private int splitAtSpace(String text) {
    int space = text.lastIndexOf(" ", this.printWidth);
    if (space < 1) {
      space = text.indexOf(" ", this.printWidth);
    }
    if (space < 1) {
      return -1;
    }

    int closeClose = text.indexOf("</", space);

    if (closeClose == -1) {
      return space;
    }
    return closeClose > this.printWidth + 20
      ? space
      : text.indexOf(" ", text.indexOf(">", closeClose));
  }

  // Analyse the dita and prettify it.
  private String prettifyDita(String dita) {
    boolean codeblock = false;
    boolean closeCodeblock = false;

    String[] lines = dita.split("\n");
    List<String> textArr = new ArrayList<>();
    List<String> strArr = new ArrayList<>();
    String doctype = null;
    boolean blockEl = false;
    int indent = 0;

    // Definition of Whitespace sensitive elements
    Pattern reStart = Pattern.compile(
      "^\\s+<(codeblock|lines|msgblock|pre)(>| )"
    );
    Pattern reEnd = Pattern.compile(".*</(codeblock|lines|msgblock|pre)>");
    Pattern reDoctype = Pattern.compile("^<\\w");
    Pattern reBlock = Pattern.compile("^\\s*<.*>$");

    // Read each line of the the DITA in turn
    for (String line : lines) {
      // For the first line re-insert the doctype
      if (doctype == null && reDoctype.matcher(line).lookingAt()) {
        doctype = line.substring(line.indexOf("<") + 1, line.indexOf(">"));

        if (doctype.contains(" ")) {
          doctype = doctype.substring(0, doctype.indexOf(" "));
        }

        textArr.add("<!DOCTYPE " + doctype + " " + getDoctype(doctype) + ">");

        if ("true".equals(addPragma) && (this.hasPragma == false)) {
          textArr.add("<!-- @format -->");
        }
      }

      // Check to see if the current element is whitespace sensitive
      if (reStart.matcher(line).lookingAt() && reEnd.matcher(line).lookingAt()) {
        // Nothing
      } else if (reStart.matcher(line).lookingAt()) {
        // Print out any text found before the codeblock.
        if (!strArr.isEmpty()) {
          textArr.add(splitText(strArr, indent + 2));
        }
        strArr.clear();
        indent = line.indexOf("<");
        codeblock = true;

      } else if (reEnd.matcher(line).lookingAt()) {
        closeCodeblock = true;
        codeblock = false;
      }

      if (closeCodeblock) {
        textArr.add(line);
        closeCodeblock = false;
      } else if (codeblock) {
        textArr.add(line);
      } else {
        // If this is a block element, format the text
        blockEl =
          reBlock.matcher(line).lookingAt() && (line + " ").split("<").length < 4;

        if (blockEl) {
          // Print out any text found within the paragraph
          if (!strArr.isEmpty()) {
            textArr.add(splitText(strArr, indent + 2));
          }
          textArr.add(line);

          indent = line.indexOf("<");
          strArr.clear();
        } else {
          String currentLine = line.trim();
          if (currentLine.length() > 0) {
            strArr.add(currentLine);
          }
        }
      }
    }
    return String.join("\n", textArr);
  }

  /**
   * Method execute.
   *
   * @throws BuildException if something goes wrong
   */
  @Override
  public void execute() {
    //    @param file    - The DITA file to clean up
    //    @param pragma  - Whether to add a pragma statement if it is missing
    //
    if (this.file == null) {
      throw new BuildException("You must supply a file");
    }

    String indentUsing = getProject().getProperty("args.style") == null
      ? "spaces"
      : getProject().getProperty("args.style");
    this.printWidth =
      getProject().getProperty("args.print-width") == null
        ? 80
        : Integer.parseInt(getProject().getProperty("args.print-width"));
    this.addPragma =
      getProject().getProperty("args.insert-pragma") == null
        ? false
        : Boolean.parseBoolean(getProject().getProperty("args.insert-pragma"));
    this.indentStyle = ("tabs".equals(indentUsing)) ? '\t' : ' ';

    try {
      String dita = org.apache.tools.ant.util.FileUtils.readFully(
        new java.io.FileReader(file)
      );
      String tidy = prettifyDita(dita);
      Echo task = (Echo) getProject().createTask("echo");
      task.setFile(new java.io.File(file));
      task.setMessage(tidy);
      task.perform();
    } catch (IOException e) {
      throw new BuildException("Unable to read file", e);
    } catch (Exception e) {
      e.printStackTrace();
      throw e;
    }
  }
}

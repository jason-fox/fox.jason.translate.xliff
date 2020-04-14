/*
 *  This file is part of the DITA-OT Translate Plug-in project.
 *  See the accompanying LICENSE file for applicable licenses.
 */

package fox.jason.translate.tasks;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.Task;
import java.util.regex.Pattern;
import org.apache.tools.ant.taskdefs.Echo;
import org.apache.tools.ant.util.FileUtils;

//  Iterator function to run a given macro against a set of files
//

public class ReinsertDoctypeTask extends Task {

  private String file;
  /**
   * Creates a new <code>ReinsertDoctypeTask</code> instance.
   */
  public ReinsertDoctypeTask() {
    super();
    this.file = null;
  }

  private void addDoctype(String doctype, List<String> textArr){
    if (doctype.contains(" ")) {
      doctype = doctype.substring(0, doctype.indexOf(' '));
    }

    textArr.add("<!DOCTYPE " + doctype + " " + getDoctype(doctype) + ">");
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
      default:
        getProject().log("Unknown Doctype: " + doctype, 1); 
    }
    return type;
  }

  private String addDoctype(String dita) {
      String[] lines = dita.split("\n");
      List<String> text = new ArrayList<>();
      String doctype = null;
      Pattern reDoctype = Pattern.compile("^<\\w");

      for (String line : lines) {
        if (doctype == null && reDoctype.matcher(line).lookingAt()) {
          doctype = line.substring(line.indexOf('<') + 1, line.indexOf('>'));
          addDoctype(doctype, text);
        }
        if (line.length() > 0) {
          text.add(line);
        }
      }
      return String.join("\n", text);
    }

  /**
   * Method setFile.
   *
   * @param file String
   */
  public void setFile(String file) {
    this.file = file;
  }

  /**
   * Method execute.
   *
   * @throws BuildException if something goes wrong
   */
  @Override
  public void execute() {
    //  @param file - A file to add a doctype to
    if (this.file == null) {
      throw new BuildException("You must supply a file to add a doctype to");
    }

    try {
      String input = FileUtils.readFully(
        new java.io.FileReader(this.file)
      );
      String output = addDoctype(input);
      Echo task = (Echo) getProject().createTask("echo");
      task.setFile(new java.io.File(file));
      task.setMessage(output);
      task.perform();
    } catch (IOException e) {
      throw new BuildException("Unable to read file", e);
    }
  
  }
}










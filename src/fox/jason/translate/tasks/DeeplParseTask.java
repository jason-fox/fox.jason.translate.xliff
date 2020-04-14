/*
 *  This file is part of the DITA-OT Translate Plug-in project.
 *  See the accompanying LICENSE file for applicable licenses.
 */

package fox.jason.translate.tasks;

import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.Task;
import org.json.simple.JSONObject;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

//  Watson Translation. Parses the response and extracts the translated text
//

public class DeeplParseTask extends Task {

  private String text;
  private String outproperty;
  private JSONParser parser;

  /**
   * Creates a new <code>DeeplParseTask</code> instance.
   */
  public DeeplParseTask() {
    super();
    this.text = null;
    this.outproperty = null;
    this.parser = new JSONParser();
  }

  /**
   * Method setText.
   *
   * @param text String
   */
  public void setText(String text) {
    this.text = text;
  }

  /**
   * Method setOutproperty.
   *
   * @param outproperty String
   */
  public void setOutproperty(String outproperty) {
    this.outproperty = outproperty;
  }

  /**
   * Method execute.
   *
   * @throws BuildException if something goes wrong
   */
  @Override
  public void execute() {
    //  @param text - The response from Deepl
    //  @param outproperty - The property to output to
    if (this.text == null) {
      throw new BuildException("You must supply a response from Deepl");
    }
    if (this.outproperty == null) {
      throw new BuildException("You must supply a property to output to");
    }

    try {
      JSONObject json = (JSONObject) this.parser
                      .parse(this.text);
      JSONArray translations = (JSONArray) json.get("translations");
      String trans = (String) ((JSONObject) translations.get(0)).get("text");
      trans = trans.replaceAll("\\\\\"", "\"");
      getProject().setProperty(this.outproperty, trans);
    } catch (ParseException e) {
      throw new BuildException("Unable to translate JSON", e);
    }

  }
}

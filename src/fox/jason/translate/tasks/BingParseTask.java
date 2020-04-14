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

// Microsoft Translation. Copies text translated by Azure cloud services to a file
//

public class BingParseTask extends Task {

  private String text;
  private String outproperty;
  private JSONParser parser;

  /**
   * Creates a new <code>BingParseTask</code> instance.
   */
  public BingParseTask() {
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
    //  @param text - The response from Microsoft Translate
    //  @param outproperty - The property to output to
    if (this.text == null) {
      throw new BuildException("You must supply a response from Microsoft Translate");
    }
    if (this.outproperty == null) {
      throw new BuildException("You must supply a property to output to");
    }

    try {
      JSONArray json = (JSONArray) this.parser
                      .parse(this.text);
      JSONArray translations = (JSONArray) ((JSONObject) json.get(0)).get("translations");
      String trans = (String) ((JSONObject) translations.get(0)).get("text");
      trans = trans.replaceAll("\\\\\"", "\"");
      trans = trans.replaceAll("class=\"notranslate\"", "translate=\"no\"");
      getProject().setProperty(this.outproperty, trans);
    } catch (ParseException e) {
      throw new BuildException("Unable to translate JSON", e);
    }
  }
}

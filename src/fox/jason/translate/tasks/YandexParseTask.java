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

//
//  Yandex Translation. Parses the response and extracts the translated text
//

public class YandexParseTask extends Task {

  private String text;
  private String outproperty;
  private JSONParser parser;

  /**
   * Creates a new <code>YandexParseTask</code> instance.
   */
  public YandexParseTask() {
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
    //  @param text - The response from Yandex Translate
    //  @param outproperty - The property to output to
    if (this.text == null) {
      throw new BuildException("You must supply a response from Yandex Translate");
    }
    if (this.outproperty == null) {
      throw new BuildException("You must supply a property to output to");
    }

    try {
      JSONObject json = (JSONObject) this.parser
                      .parse(this.text);
      JSONArray texts = (JSONArray) json.get("text");
      String trans = (String) texts.get(0);
      trans = trans.replaceAll("\\\\\"", "\"");
      trans = trans.replaceAll("class=\"notranslate\"", "translate=\"no\"");
      getProject().setProperty(this.outproperty, trans);
    } catch (ParseException e) {
      throw new BuildException("Unable to translate JSON", e);
    }

  }
}

/*
 *  This file is part of the DITA-OT Translate Plug-in project.
 *  See the accompanying LICENSE file for applicable licenses.
 */

package fox.jason.translate.tasks;

import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.Task;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.io.UnsupportedEncodingException;

//
//  Converts a value to URI Encoding
//

public class UrlEncodeTask extends Task {

  private String to;
  private String string;

  /**
   * Creates a new <code>UriEncodeTask</code> instance.
   */
  public UrlEncodeTask() {
    super();
    this.to = null;
    this.string = null;
  }

  /**
   * Method setTo.
   *
   * @param to String
   */
  public void setTo(String to) {
    this.to = to;
  }

  /**
   * Method setString.
   *
   * @param string String
   */
  public void setString(String string) {
    this.string = string;
  }

  // Method to encode a string value using `UTF-8` encoding scheme
  private String encodeURIComponent(String value) {
      try {
          return URLEncoder.encode(value, StandardCharsets.UTF_8.toString());
      } catch (UnsupportedEncodingException ex) {
          throw new BuildException("Unable to encode URI", ex);
      }
  }

  /**
   * Method execute.
   *
   * @throws BuildException if something goes wrong
   */
  @Override
  public void execute() {

    //  @param  string -   The value to convert
    //  @param  to -  The property to set
    if (this.string == null) {
      throw new BuildException("You must supply a value to convert");
    }
    if (this.to == null) {
      throw new BuildException("You must supply a property to set");
    }
   
    getProject().setProperty(this.to, encodeURIComponent(this.string));
  }
}

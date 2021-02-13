/*
 *  This file is part of the DITA-OT Pretty DITA Plug-in project.
 *  See the accompanying LICENSE file for applicable licenses.
 */

package fox.jason.translate.tasks;

import java.util.ArrayList;
import java.util.List;
import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.DirectoryScanner;
import org.apache.tools.ant.Task;
import org.apache.tools.ant.taskdefs.MacroInstance;
import org.apache.tools.ant.types.FileSet;

//
//    Iterator function to run a given macro against a set of files
//

public class IterateFilesetTask extends Task {
  /**
   * Field filesets.
   */
  private List<FileSet> filesets;
  /**
   * Field todir.
   */
  private String macro;
  /**
   * Field todir.
   */
  private String todir;

  /**
   * Field dir.
   */
  private String dir;

  /**
   * Creates a new <code>IterateFilesetTask</code> instance.
   */
  public IterateFilesetTask() {
    super();
    this.dir = null;
    this.todir = null;
    this.macro = null;
    this.filesets = new ArrayList<>();
  }

  /**
   * Method setDir.
   *
   * @param dir String
   */
  public void setDir(String dir) {
    this.dir = dir;
  }

  /**
   * Method setTodir.
   *
   * @param todir String
   */
  public void setTodir(String todir) {
    this.todir = todir;
  }

  /**
   * Method setMacro.
   *
   * @param macro String
   */
  public void setMacro(String macro) {
    this.macro = macro;
  }

  /**
   * @param set FileSet
   */
  public void addFileset(FileSet set) {
    this.filesets.add(set);
  }

  /**
   * Method execute.
   *
   * @throws BuildException if something goes wrong
   */
  @Override
  public void execute() {
    //    @param toDir - The output location of the files
    //    @param dir  - The location of the files to process
    //    @param macro - A macro to run.
    //    @param fileset - A set of files
    if (this.dir == null) {
      throw new BuildException("You must supply a source directory");
    }
    if (this.macro == null) {
      throw new BuildException("You must supply a macro");
    }
    if (filesets.isEmpty()) {
      throw new BuildException("You must supply a set of files");
    }

    for (FileSet fileset : this.filesets) {
      DirectoryScanner scanner = fileset.getDirectoryScanner(getProject());
      scanner.scan();

      for (String file : scanner.getIncludedFiles()) {
        MacroInstance task = (MacroInstance) getProject()
          .createTask(this.macro);
        try {
          task.setDynamicAttribute("file", this.dir + "/" + file);
          if (this.todir != null){
            task.setDynamicAttribute("toDir", this.todir);
          }
          task.execute();
        } catch (Exception err) {
          throw new BuildException(err);
        }
      }
    }
  }
}
package xxl.app.main;

import pt.tecnico.uilib.forms.Form;
import pt.tecnico.uilib.menus.Command;
import xxl.core.Calculator;
import xxl.core.exception.MissingFileAssociationException;
import xxl.core.exception.UnavailableFileException;

import java.io.IOException;

/**
 * Save to file under current name (if unnamed, query for name).
 */
class DoSave extends Command<Calculator> {

  DoSave(Calculator receiver) {
    super(Label.SAVE, receiver, xxl -> xxl.getSpreadsheet() != null);
  }

  @Override
  protected final void execute() {
    String filename = _receiver.getFileName();
    // checks if the file is named
    try {
      if (filename == null) {
        Form f1 = new Form();
        f1.addStringField("filename", Message.newSaveAs());
        filename = f1.stringField("filename");
        _receiver.saveAs(filename);
      } else {
        _receiver.save();
      }
    } catch (UnavailableFileException | IOException | MissingFileAssociationException e) {
      _display.popup(Message.fileNotFound(filename));
    }
  }
}

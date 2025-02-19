package xxl.app.main;


import pt.tecnico.uilib.forms.Form;
import pt.tecnico.uilib.menus.Command;
import pt.tecnico.uilib.menus.CommandException;
import xxl.core.Calculator;
import xxl.core.exception.MissingFileAssociationException;
import xxl.core.exception.UnavailableFileException;
import xxl.app.exception.FileOpenFailedException;

import java.io.IOException;

/**
 * Open existing file.
 */
class DoOpen extends Command<Calculator> {

  DoOpen(Calculator receiver) {
    super(Label.OPEN, receiver);
    addStringField("file", Message.openFile());
  }

  @Override
  protected final void execute() throws CommandException {
    if (_receiver.getSpreadsheet() != null) { // In case there is an active sheet
      if (_receiver.getSpreadsheet().getChanged() && Form.confirm(Message.saveBeforeExit())) {
        new DoSave(_receiver).performCommand();
      }
    }
    try {
      _receiver.load(stringField("file"));

    } catch (MissingFileAssociationException mfe) {
      _display.popup(Message.fileNotFound(stringField("file")));
    } catch (UnavailableFileException e) {
      throw new FileOpenFailedException(e);
    }
  }
}



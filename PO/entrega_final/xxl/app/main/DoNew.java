package xxl.app.main;

import pt.tecnico.uilib.forms.Form;
import pt.tecnico.uilib.menus.Command;
import pt.tecnico.uilib.menus.CommandException;
import xxl.core.Calculator;
import xxl.core.Spreadsheet;

/**
 * Open a new file.
 */
public class DoNew extends Command<Calculator> {

  DoNew(Calculator receiver) {
    super(Label.NEW, receiver);
    addIntegerField("lines", Message.lines());
    addIntegerField("columns", Message.columns());
  }

  @Override
  protected final void execute() throws CommandException {
    if (_receiver.getSpreadsheet() != null) {
      if (_receiver.getSpreadsheet().getChanged() && Form.confirm(Message.saveBeforeExit())) {
        new DoSave(_receiver).performCommand();
      }
    }
      _receiver.createNewSpreadSheet(integerField("lines"), integerField("columns"));
  }
}
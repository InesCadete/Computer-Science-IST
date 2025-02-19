package xxl.app.search;

import pt.tecnico.uilib.menus.Command;
import xxl.core.Cell;
import xxl.core.Spreadsheet;
import xxl.core.exception.UnrecognizedEntryException;
// FIXME import classes

/**
 * Command for searching function names.
 */
class DoShowFunctions extends Command<Spreadsheet> {

  DoShowFunctions(Spreadsheet receiver) {
    super(Label.SEARCH_FUNCTIONS, receiver);
    addStringField("functionName", xxl.app.search.Message.searchFunction());
  }

  @Override
  protected final void execute() {
    try {

      for (Cell cell : _receiver.searchByFunctionName(stringField("functionName"))) {
        _display.addLine(cell.toString());
      }

    } catch (UnrecognizedEntryException e) {
      _display.addLine(e.getMessage());

    }
    _display.display();  }

}

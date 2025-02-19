package xxl.app.search;

import pt.tecnico.uilib.menus.Command;
import xxl.app.exception.InvalidCellRangeException;
import xxl.core.Cell;
import xxl.core.Spreadsheet;
import xxl.core.exception.InvalidCellAddressException;
import xxl.core.exception.InvalidRangeException;
import xxl.core.exception.UnrecognizedEntryException;

import java.util.List;
import xxl.core.Cell;
// FIXME import classes

/**
 * Command for searching content values.
 */
class DoShowValues extends Command<Spreadsheet> {

  DoShowValues(Spreadsheet receiver) {
    super(Label.SEARCH_VALUES, receiver);
    addStringField("value", xxl.app.search.Message.searchValue());
  }

  @Override
  protected final void execute() {

    try {

      for (Cell cell : _receiver.searchByValue(stringField("value"))) {
        _display.addLine(cell.toString());
      }

    } catch (UnrecognizedEntryException e) {
      _display.addLine(e.getMessage());

    }
    _display.display();
  }
}

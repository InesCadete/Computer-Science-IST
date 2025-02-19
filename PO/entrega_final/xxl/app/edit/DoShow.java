package xxl.app.edit;

import pt.tecnico.uilib.menus.Command;

import pt.tecnico.uilib.menus.CommandException;
import xxl.app.edit.Message;
import xxl.app.exception.InvalidCellRangeException;
import xxl.core.exception.InvalidRangeException;
import xxl.core.Cell;
import xxl.core.Spreadsheet;

import java.util.Collections;
import java.util.List;

import xxl.core.exception.UnrecognizedEntryException;

// FIXME import classes

/**
 * Class for searching functions.
 */
public class DoShow extends Command<Spreadsheet> {

  DoShow(Spreadsheet receiver) {
    super(Label.SHOW, receiver);
    addStringField("address", Message.address());
  }

  @Override
  protected final void execute() throws CommandException {

    try {

      for (Cell cell : _receiver.getRangeFromSpreadsheet(stringField("address"))) {
        _display.addLine(cell.toString());
      }
      _display.display();

    } catch (InvalidRangeException e) {
      throw new InvalidCellRangeException(stringField("address"));
    }
  }
}

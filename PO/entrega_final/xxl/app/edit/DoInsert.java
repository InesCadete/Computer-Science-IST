package xxl.app.edit;

import pt.tecnico.uilib.menus.Command;
import pt.tecnico.uilib.menus.CommandException;
import xxl.app.exception.InvalidCellRangeException;
import xxl.core.Cell;
import xxl.core.Spreadsheet;
// FIXME import classes

import xxl.core.exception.InvalidCellAddressException;
import xxl.core.exception.InvalidRangeException;
import xxl.core.exception.UnrecognizedEntryException;

/**
 * Class for inserting data.
 */
class DoInsert extends Command<Spreadsheet> {

  DoInsert(Spreadsheet receiver) {
    super(Label.INSERT, receiver);
    addStringField("address", Message.address());
    addStringField("content", Message.contents());
  }

  @Override
  protected final void execute() throws CommandException {

    try {
      _receiver.insertContentInRange(stringField("address"), stringField("content"));

    } catch (InvalidRangeException e) {
      throw new InvalidCellRangeException(stringField("address"));
    } catch (UnrecognizedEntryException | InvalidCellAddressException e) {

      //_display.addLine(e.getMessage());
      }
  }
}
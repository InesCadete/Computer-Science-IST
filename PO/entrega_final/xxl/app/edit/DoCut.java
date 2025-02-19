package xxl.app.edit;

import pt.tecnico.uilib.menus.Command;
import pt.tecnico.uilib.menus.CommandException;
import xxl.app.exception.InvalidCellRangeException;
import xxl.core.Cell;
import xxl.core.Range;
import xxl.core.Spreadsheet;
import xxl.core.exception.InvalidRangeException;
// FIXME import classes

/**
 * Cut command.
 */
class DoCut extends Command<Spreadsheet> {

  DoCut(Spreadsheet receiver) {
    super(Label.CUT, receiver);
    addStringField("address", Message.address());
  }

  @Override
  protected final void execute() throws CommandException {

    try {
      // copy the cells in the given Range to CutBuffer
      // delete the cells of the given Range
      _receiver.cutBufferCut(stringField("address"));

    } catch (InvalidRangeException e) {
      throw new InvalidCellRangeException(stringField("address"));
    }
  }
}
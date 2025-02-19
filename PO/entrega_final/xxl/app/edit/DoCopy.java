package xxl.app.edit;

import pt.tecnico.uilib.menus.Command;
import pt.tecnico.uilib.menus.CommandException;
import xxl.app.exception.InvalidCellRangeException;
import xxl.core.Spreadsheet;
import xxl.core.exception.InvalidRangeException;
// FIXME import classes

import xxl.core.exception.InvalidRangeException;
import xxl.core.Content;
import xxl.core.Range;
import xxl.core.exception.UnrecognizedEntryException;
import xxl.core.exception.InvalidCellAddressException;
/**
 * Copy command.
 */
class DoCopy extends Command<Spreadsheet> {

  DoCopy(Spreadsheet receiver) {
    super(Label.COPY, receiver);
    addStringField("address", Message.address());
  }

  @Override
  protected final void execute() throws CommandException {
    try {
    // copy to CutBuffer
    _receiver.cutBufferCopy(stringField("address"));

    } catch (InvalidRangeException e) {
      throw new InvalidCellRangeException(stringField("address"));
    }
  }
}


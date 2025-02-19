package xxl.app.edit;

import pt.tecnico.uilib.menus.Command;
import pt.tecnico.uilib.menus.CommandException;
import xxl.app.exception.InvalidCellRangeException;
import xxl.core.CutBuffer;
import xxl.core.Spreadsheet;
// FIXME import classes

import xxl.core.Range;
import xxl.core.exception.InvalidRangeException;

/**
 * Paste command.
 */
class DoPaste extends Command<Spreadsheet> {

  DoPaste(Spreadsheet receiver) {
    super(Label.PASTE, receiver);
    addStringField("address", Message.address());
  }

  @Override
  protected final void execute() throws CommandException {
    try {

      _receiver.cutBufferPaste(stringField("address"));

    } catch (InvalidRangeException e) {
      throw new InvalidCellRangeException(stringField("address"));
    }
  }
}

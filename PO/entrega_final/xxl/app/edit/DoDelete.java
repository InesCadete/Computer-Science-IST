package xxl.app.edit;

import pt.tecnico.uilib.menus.Command;
import pt.tecnico.uilib.menus.CommandException;
import xxl.app.exception.InvalidCellRangeException;
import xxl.core.Spreadsheet;
// FIXME import classes

import xxl.core.exception.InvalidRangeException;
/**
 * Delete command.
 */
class DoDelete extends Command<Spreadsheet> {

  DoDelete(Spreadsheet receiver) {
    super(Label.DELETE, receiver);
    addStringField("address", Message.address());
  }

  @Override
  protected final void execute() throws CommandException {
    try {

    _receiver.deleteContentInRange(stringField("address"));

    } catch (InvalidRangeException e) {
      throw new InvalidCellRangeException(stringField("address"));
    }
  }
}


package xxl.app.edit;

import pt.tecnico.uilib.menus.Command;
import pt.tecnico.uilib.menus.CommandException;
import xxl.app.exception.InvalidCellRangeException;
import xxl.core.Cell;
import xxl.core.Spreadsheet;
// FIXME import classes

/**
 * Show cut buffer command.
 */
class DoShowCutBuffer extends Command<Spreadsheet> {

  DoShowCutBuffer(Spreadsheet receiver) {
    super(Label.SHOW_CUT_BUFFER, receiver);
  }

  @Override
  protected final void execute() throws CommandException {

    for (Cell cell : _receiver.getCutBufferCells()) {
        _display.addLine(cell.toString());
    }
    _display.display();
  }
}

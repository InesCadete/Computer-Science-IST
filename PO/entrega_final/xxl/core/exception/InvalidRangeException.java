package xxl.core.exception;

import xxl.core.Spreadsheet;

/**
 *  Thrown when invalid cell range is used.
 */
public class InvalidRangeException  extends Exception {
    private final String _range;
    private final Spreadsheet _sheet;
    /** @param range String input format of a range.
     */
    public InvalidRangeException(String range, Spreadsheet sheet) {
        _sheet = sheet;
        _range = range;
    }
    public String getRange() {
        return _range;
    }

    @Override
    public String getMessage() {
        return "Invalid range :"+_range+" -> Spreadsheet: "
                +_sheet.getRows()+" Linhas e "
                +_sheet.getColumns()+" Colunas.";
    }
}

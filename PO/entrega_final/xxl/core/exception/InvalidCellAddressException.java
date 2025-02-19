package xxl.core.exception;

import xxl.core.Spreadsheet;

public class InvalidCellAddressException extends Exception {
    private final Spreadsheet _sheet;
    public InvalidCellAddressException(int row, int column, Spreadsheet sheet) {
        super("Invalid address for this spreadsheet Cell -> "+row+";"+column
                +"Spreadsheet dimensions -> "
                +sheet.getRows()+" Rows and "
                +sheet.getColumns()+" Columns");
        _sheet = sheet;
    }
    public Spreadsheet getSheet() {
        return _sheet;
    }
}

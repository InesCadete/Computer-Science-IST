package xxl.core;
import java.io.Serial;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

public class Range implements Serializable {
    @Serial
    private static final long serialVersionUID = 202308312359L;
    private final int _beginRow;
    private final int _beginColumn;
    private final int _endRow;
    private final int _endColumn;
    private boolean _horizontal;
    private final Spreadsheet _sheet;

    Range(int firstRow, int firstColumn, int lastRow, int lastColumn, Spreadsheet sheet) {
        _beginRow = firstRow;
        _beginColumn = firstColumn;
        _endRow = lastRow;
        _endColumn = lastColumn;
        _sheet = sheet;
        if (firstRow == lastRow)
            _horizontal = true;
        else
           _horizontal = false;

    }
    int getBeginRow() {
        return _beginRow;
    }
    int getBeginColumn() {
        return _beginColumn;
    }
    int getEndRow() {
        return _endRow;
    }
    int getEndColumn() {
        return _endColumn;
    }
    boolean getHorizontal() {
        return _horizontal;
    }


    public int getSize() {

        if(_horizontal) {
            return _endColumn - _beginColumn + 1;
        }
        return _endRow - _beginRow + 1;
    }

    void setHorizontal(Boolean b) {
        _horizontal = b;
    }
    List<Cell> getCells() {
        List<Cell> aux = new ArrayList<>();
        for (int i = _beginRow; i <= _endRow; i++) {
            for (int j = _beginColumn; j <= _endColumn; j++) {
               aux.add(_sheet.getCell(i,j));
            }
        }
        return aux;
    }


}

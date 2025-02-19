package xxl.core;

import xxl.core.exception.EmptyCellException;

import java.io.Serial;
import java.io.Serializable;

public class Reference extends Content implements Serializable, Visited {
    @Serial
    private static final long serialVersionUID = 202308312359L;
    private final int _row;
    private final int _column;
    private final Spreadsheet _sheet;
    public Reference(int row, int column, Spreadsheet sheet) {
        _row = row;
        _column = column;
        _sheet = sheet;
    }
    public int getRow() { return _row;}
    public int getColumn() { return _column;}
    public Spreadsheet getSpreadSheet() {
        return _sheet;
    }

    @Override
    public String toString() {
        Cell aux = _sheet.getCell(_row, _column);
        String s;
        try { s = aux.value().toString() + "=" +
                    Integer.toString(aux.getRow()) + ";" +
                    Integer.toString(aux.getColumn());
        } catch (EmptyCellException e) {
            s = "#VALUE=" + Integer.toString(aux.getRow()) + ";" +
                    Integer.toString(aux.getColumn());
        }
        return s;
    }
    @Override
    Literal value() throws EmptyCellException {
        if (_sheet.getCell(_row, _column).value() == null)
            throw new EmptyCellException();
        return _sheet.getCell(_row, _column).value();
    }
    @Override
    Content copyContent() {
        return new Reference(_row, _column, _sheet);
    }
    @Override
    public String accept(Visitor v) {
        return v.visitReference(this);
    }
}

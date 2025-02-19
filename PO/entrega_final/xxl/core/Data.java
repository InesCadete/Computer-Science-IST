package xxl.core;

import java.io.Serial;
import java.io.Serializable;
import java.util.ArrayList;

/**
 * The `Data` class represents the contents of a Spreadsheet (cells).
 *
 * Usage:
 * To encapsulate the information contained inside a SpreadSheet
 *
 */

class Data implements Serializable {
    @Serial
    private static final long serialVersionUID = 202308312359L;

    private final int _rows;
    private final int _columns;
    private ArrayList<ArrayList<Cell>> _data;

    /**
     * Constructor: Creates and instance of the 'Data' class
     *              and associates it with a number of rows and columns
     *
     * @param rows number of rows
     * @param columns number of columns
     */
    Data(int rows, int columns) {
        _rows = rows;
        _columns = columns;
        _data = new ArrayList<>();

        for (int i = 0; i < _rows; i++) {
            ArrayList<Cell> dataRow = new ArrayList<>();
            for (int j = 0; j < _columns; j++ ) {
                Cell cell = new Cell(i+1, j+1);
                dataRow.add(cell);
            }
            _data.add(dataRow);
        }
    }

    /**
     * Gets a cell from Data by its position (row and column)
     *
     * @param row number of rows
     * @param column number of columns
     * @return cell with the specified position
     */
    Cell getCellFromData(int row, int column) {
        int rowIndex = row - 1;
        int columnIndex = column - 1;
        return _data.get(rowIndex).get(columnIndex);
    }

    /**
     * Adds content to the cell in a specified position
     *
     * @param row number of rows
     * @param column number of columns
     * @param content content of the cell
     */
    void addContent2Data(int row, int column, Content content) {
        getCellFromData(row, column).setContent(content);
        getCellFromData(row, column).notifyCellObserver();
    }

    /**
     * Deletes content of the cell in a specified position
     *
     * @param row number of rows
     * @param column number of columns
     */
    void deleteCellFromData(int row, int column) {
        getCellFromData(row, column).setContent(null);
        getCellFromData(row, column).notifyCellObserver();
    }
}
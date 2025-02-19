package xxl.core;

public interface ObservedCell {
    public void registerCellObserver(CellObserver o);
    public void removeCellObserver(CellObserver o);
    public void notifyCellObserver();
}
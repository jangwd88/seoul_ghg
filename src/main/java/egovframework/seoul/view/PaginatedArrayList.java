package egovframework.seoul.view;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

@SuppressWarnings("all")
public class PaginatedArrayList implements PaginatedList {
	
    private static final ArrayList EMPTY_LIST = new ArrayList(0);
    private List list;
    private List page;
    private int pageSize;
    private int totalSize;
    private int totalPage;
    private int index;
    private int currPage;
    private int startIndex;
	private String startNo;
	private String revStartNo;

	public PaginatedArrayList() {                                                      
	}
	
    public PaginatedArrayList(int pageSize) {
        this.pageSize = pageSize;
        this.index = 0;
        this.totalSize = -1;
        this.list = new ArrayList();
        repaginate();
    }

    public PaginatedArrayList(int initialCapacity, int pageSize) {
        this.pageSize = pageSize;
        this.index = 0;
        this.totalSize = -1;
        this.list = new ArrayList(initialCapacity);
        repaginate();
    }

    public PaginatedArrayList(Collection c, int pageSize) {
        this.pageSize = pageSize;
        this.index = 0;
        this.totalSize = -1;
        this.list = new ArrayList(c);
        repaginate();
    }

    public PaginatedArrayList(Collection c, int pageSize, int totalSize) {
        this.pageSize = pageSize;
        this.index = 0;
        this.totalSize = totalSize;
        this.list = new ArrayList(c);
        this.startIndex = 1;
        repaginate();
    }

    private void repaginate() {
        if (list.isEmpty()) {
            page = EMPTY_LIST;
        } else {
            int start = index * pageSize;
            int end = (start + pageSize) - 1;

            if (end >= list.size()) {
                end = list.size() - 1;
            }

            if (start >= list.size()) {
                index = 0;
                repaginate();
            } else if (start < 0) {
                index = list.size() / pageSize;

                if ((list.size() % pageSize) == 0) {
                    index--;
                }

                repaginate();
            } else {
                page = list.subList(start, end + 1);
            }
        }
    }

    /* List accessors (uses page) */
    public int size() {
        return page.size();
    }

    public boolean isEmpty() {
        return page.isEmpty();
    }

    public boolean contains(Object o) {
        return page.contains(o);
    }

    public Iterator iterator() {
        return page.iterator();
    }

    public Object[] toArray() {
        return page.toArray();
    }

    public Object[] toArray(Object[] a) {
        return page.toArray(a);
    }

    public boolean containsAll(Collection c) {
        return page.containsAll(c);
    }

    public Object get(int index) {
        return page.get(index);
    }

    public int indexOf(Object o) {
        return page.indexOf(o);
    }

    public int lastIndexOf(Object o) {
        return page.lastIndexOf(o);
    }

    public ListIterator listIterator() {
        return page.listIterator();
    }

    public ListIterator listIterator(int index) {
        return page.listIterator(index);
    }

    public List subList(int fromIndex, int toIndex) {
        return page.subList(fromIndex, toIndex);
    }

    /* List mutators (uses master list) */
    public boolean add(Object o) {
        boolean b = list.add(o);
        repaginate();

        return b;
    }

    public boolean remove(Object o) {
        boolean b = list.remove(o);
        repaginate();

        return b;
    }

    public boolean addAll(Collection c) {
        boolean b = list.addAll(c);
        repaginate();

        return b;
    }

    public boolean addAll(int index, Collection c) {
        boolean b = list.addAll(index, c);
        repaginate();

        return b;
    }

    public boolean removeAll(Collection c) {
        boolean b = list.removeAll(c);
        repaginate();

        return b;
    }

    public boolean retainAll(Collection c) {
        boolean b = list.retainAll(c);
        repaginate();

        return b;
    }

    public void clear() {
        list.clear();
        repaginate();
    }

    public Object set(int index, Object element) {
        Object o = list.set(index, element);
        repaginate();

        return o;
    }

    public void add(int index, Object element) {
        list.add(index, element);
        repaginate();
    }

    public Object remove(int index) {
        Object o = list.remove(index);
        repaginate();

        return o;
    }

    /* Paginated List methods */
    public int getPageSize() {
        return pageSize;
    }

    public boolean isFirstPage() {
        return index == 0;
    }

    public boolean isMiddlePage() {
        return !(isFirstPage() || isLastPage());
    }

    public boolean isLastPage() {
        return (list.size() - ((index + 1) * pageSize)) < 1;
    }

    public boolean isNextPageAvailable() {
        return !isLastPage();
    }

    public boolean isPreviousPageAvailable() {
        return !isFirstPage();
    }

    public boolean nextPage() {
        if (isNextPageAvailable()) {
            index++;
            repaginate();

            return true;
        } else {
            return false;
        }
    }

    public boolean previousPage() {
        if (isPreviousPageAvailable()) {
            index--;
            repaginate();

            return true;
        } else {
            return false;
        }
    }

    public void gotoPage(int pageNumber) {
        index = pageNumber;
        repaginate();
    }

    public int getPageIndex() {
        return index;
    }

    public int getTotalSize() {
        if (this.totalSize == -1) {
            return list.size();
        }

        return this.totalSize;
    }

    public int getStartIndex() {
    	return this.startIndex;
    }
    public void setStartIndex(int pageNo) {
    	this.startIndex = pageNo;
    }

    public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}


	public int getCurrPage() {
		return currPage;
	}

	public void setCurrPage(int currPage) {
		this.currPage = currPage;
	}

	public String getStartNo() {
    	return this.startIndex+"";
    }

	public String getRevStartNo() {
		String revStartNo = ""+ (this.totalPage -((this.pageSize*this.currPage)-this.pageSize));
		return revStartNo;
	}
}

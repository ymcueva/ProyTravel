package pe.com.paxtravel.tree.decision;

import java.util.List;

import pe.com.paxtravel.tree.data.*;


public interface Tree {
	
	public void setAttribute(String att);
		
	public String getAttribute();
	
	public String evaluate(List<String> attributes, List<String> instance);
	
	public List<String> evaluate(TableManager instances);
	
	public boolean evaluate(TableManager instances, String file);
	
	public TableManager ClassifyImportedCases(String pathin, String pathout, String separator);

	public int getDepth();
	
	public boolean isLeaf();
	
	public int getMaxBranchingFactor();

}

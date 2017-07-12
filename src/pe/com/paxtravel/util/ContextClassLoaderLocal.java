package pe.com.paxtravel.util;

import java.util.Map;
import java.util.WeakHashMap;

public class ContextClassLoaderLocal
{
  private Map valueByClassLoader = new WeakHashMap();
  private boolean globalValueInitialized = false;
  private Object globalValue;
  
  protected Object initialValue()
  {
    return null;
  }
  
  public synchronized Object get()
  {
    this.valueByClassLoader.isEmpty();
    try
    {
      ClassLoader contextClassLoader = Thread.currentThread().getContextClassLoader();
      if (contextClassLoader != null)
      {
        Object value = this.valueByClassLoader.get(contextClassLoader);
        if ((value == null) && (!this.valueByClassLoader.containsKey(contextClassLoader)))
        {
          value = initialValue();
          this.valueByClassLoader.put(contextClassLoader, value);
        }
        return value;
      }
    }
    catch (SecurityException e) {}
    if (!this.globalValueInitialized)
    {
      this.globalValue = initialValue();
      this.globalValueInitialized = true;
    }
    return this.globalValue;
  }
  
  public synchronized void set(Object value)
  {
    this.valueByClassLoader.isEmpty();
    try
    {
      ClassLoader contextClassLoader = Thread.currentThread().getContextClassLoader();
      if (contextClassLoader != null)
      {
        this.valueByClassLoader.put(contextClassLoader, value);
        return;
      }
    }
    catch (SecurityException e) {}
    this.globalValue = value;
    this.globalValueInitialized = true;
  }
  
  public synchronized void unset()
  {
    try
    {
      ClassLoader contextClassLoader = Thread.currentThread().getContextClassLoader();
      unset(contextClassLoader);
    }
    catch (SecurityException e) {}
  }
  
  public synchronized void unset(ClassLoader classLoader)
  {
    this.valueByClassLoader.remove(classLoader);
  }
}

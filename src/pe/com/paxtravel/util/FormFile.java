package pe.com.paxtravel.util;

import java.io.ByteArrayInputStream;
import java.io.InputStream;

/**
 * @author jjurado
 * @since 27.08.2015 Formfile.
 */
public class FormFile {

    private String name;
    private String contentType;
    private InputStream inputStream;
    private long size;
    private byte[] bytes;
    private String extension;

    public FormFile() {
    }

    public FormFile(String name, String contentType, InputStream inputStream, long size, byte[] bytes, String extension) {
        this.name = name;
        this.contentType = contentType;
        this.inputStream = inputStream;
        this.size = size;
        this.bytes = bytes;
        this.extension = extension;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getContentType() {
        return contentType;
    }

    public void setContentType(String contentType) {
        this.contentType = contentType;
    }

    public InputStream getInputStream() {
        return inputStream;
    }

    public void setInputStream(InputStream inputStream) {
        this.inputStream = inputStream;
    }

    public long getSize() {
        return size;
    }

    public void setSize(long size) {
        this.size = size;
    }

    public byte[] getBytes() {
        return bytes;
    }

    public void setBytes(byte[] bytes) {
        this.bytes = bytes;
    }

    public ByteArrayInputStream getByteArrayInputStream() {
        return new ByteArrayInputStream(getBytes());
    }

    public String getExtension() {
        return extension;
    }

    public void setExtension(String extension) {
        this.extension = extension;
    }

}

package org.skyve.impl.web.faces.converters.date;

import javax.faces.application.FacesMessage;
import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.convert.Converter;
import javax.faces.convert.ConverterException;

import org.skyve.domain.types.DateOnly;
import org.skyve.impl.util.UtilImpl;

public class DD_MM_YYYY extends org.skyve.domain.types.converters.date.DD_MM_YYYY implements Converter {
	@Override
	public Object getAsObject(FacesContext fc, UIComponent component, String value) {
    	String processedValue = UtilImpl.processStringValue(value);
    	if (processedValue != null) {
			try {
				return fromDisplayValue(processedValue);
			}
			catch (Exception e) {
				throw new ConverterException(new FacesMessage(FacesMessage.SEVERITY_ERROR,
																"Invalid date (use DD-MM-YYYY format)",
																"Invalid date (use DD-MM-YYYY format)"),
												e);
			}
		}
		return null;
	}

	@Override
	public String getAsString(FacesContext fc, UIComponent component, Object value) {
		try {
			return toDisplayValue((DateOnly) value);
		}
		catch (@SuppressWarnings("unused") Exception e) {
			return null;
		}
	}
}

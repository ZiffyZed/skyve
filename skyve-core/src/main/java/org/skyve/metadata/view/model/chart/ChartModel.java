package org.skyve.metadata.view.model.chart;

import org.skyve.domain.Bean;
import org.skyve.metadata.MetaData;

public abstract class ChartModel<T extends Bean> implements MetaData {
	private static final long serialVersionUID = -7777796858800486670L;

	private T bean;
	public T getBean() {
		return bean;
	}
	public void setBean(T bean) {
		this.bean = bean;
	}

	public abstract ChartData getChartData();
}

package modules.admin.Configuration;

import static org.hamcrest.CoreMatchers.*;
import static org.junit.Assert.assertThat;

import org.junit.Before;
import org.junit.Test;

import modules.admin.ModulesUtil;
import modules.admin.domain.Configuration;
import util.AbstractH2Test;

public class ConfigurationBizletTest extends AbstractH2Test {

	private ConfigurationBizlet bizlet;
	private ConfigurationExtension configuration;

	@Before
	public void setup() throws Exception {
		bizlet = new ConfigurationBizlet();
		configuration = Configuration.newInstance();
	}

	@Test
	public void testNewInstance() throws Exception {
		// validate the test data
		assertThat(ModulesUtil.currentAdminUserProxy(), is(notNullValue()));

		// call the method under test
		ConfigurationExtension result = bizlet.newInstance(configuration);

		// verify the result
		assertThat(result, is(notNullValue()));
		assertThat(result.getEmailFrom(), is(notNullValue()));
		assertThat(result.getStartup(), is(notNullValue()));
	}

}

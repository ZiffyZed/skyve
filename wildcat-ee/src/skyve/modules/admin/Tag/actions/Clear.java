package modules.admin.Tag.actions;

import org.skyve.CORE;
import org.skyve.metadata.controller.ServerSideAction;
import org.skyve.metadata.controller.ServerSideActionResult;
import org.skyve.persistence.Persistence;
import org.skyve.persistence.SQL;
import org.skyve.web.WebContext;

import modules.admin.domain.Tag;

public class Clear implements ServerSideAction<Tag> {
	/**
	 * For Serialization
	 */
	private static final long serialVersionUID = 2886341074753936987L;

	/**
	 * Update the payment batch details.
	 */
	@Override
	public ServerSideActionResult execute(Tag bean, WebContext webContext)
	throws Exception {
		
		//clear tagged values
		StringBuilder deleteSQL = new StringBuilder();
		deleteSQL.append("delete from ADM_Tagged where tag_id = ");
		deleteSQL.append("'").append(bean.getBizId()).append("'");
		deleteSQL.append(" and bizCustomer = '").append(bean.getBizCustomer()).append("'");
		
		Persistence persistence = CORE.getPersistence();
		SQL sql = persistence.newSQL(deleteSQL.toString());
		persistence.executeInsecureSQLDML(sql);
		
		bean.setNumberTagged(new Integer(0));
		
		return new ServerSideActionResult(bean);
	}
}

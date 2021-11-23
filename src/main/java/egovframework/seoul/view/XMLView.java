package egovframework.seoul.view;

import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.view.AbstractView;

/**
 * Retrieve the model delivered by the controller and render it as xml.
 *
 * @author bwalsh
 */

@SuppressWarnings("all")
public class XMLView extends AbstractView {

	/** Logger for this class */
	protected final Logger logger = LoggerFactory.getLogger(getClass());

	/**
	 * @param map
	 *            - Map with name Strings as keys and corresponding model
	 *            objects as values (Map can also be null in case of empty
	 *            model)
	 * @param request
	 *            - current HTTP request
	 * @param response
	 *            - HTTP response we are building
	 */
	protected void renderMergedOutputModel(Map map, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		/*
		 * logger.info("Starting XML rendering of " + this.getBeanName());
		 */

		String xmlHeader = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n";

		StringBuffer xmlSb = new StringBuffer();
		xmlSb.append(xmlHeader);
		xmlSb.append("<xml>");

		if (!map.isEmpty()) {
			Iterator k = map.keySet().iterator();
			String key = "";
			while (k.hasNext()) {
				key = (String) k.next();
				xmlSb.append("<" + key + ">" + map.get(key) + "</" + key + ">");
			}
		}
		xmlSb.append("</xml>");

		response.setContentType("application/xml");
		response.setCharacterEncoding("utf-8");
		response.setHeader("Cache-Control", "no-cache");
		response.setContentLength(xmlSb.toString().getBytes("utf-8").length);

		response.getWriter().print(xmlSb.toString());

		/*
		 * // create xml via xstream XStream xstream = new XStream(new
		 * DomDriver());
		 *
		 * // get the model from the map passed created by the controller Object
		 * model = null;
		 *
		 * if (map.get("AJAX_MODEL") != null ) { model = map.get("AJAX_MODEL");
		 * } else { model = map; }
		 *
		 *
		 * // if the model is null, we have an exception String xml = null; if
		 * (model != null) { xml = xstream.toXML(model); } else { xml =
		 * xstream.toXML(map); }
		 *
		 * if (StringUtils.isEmpty(getContentType())) {
		 * setContentType("text/xml;charset=utf-8"); }
		 *
		 * response.setContentType("text/xml;charset=utf-8");
		 * response.setHeader("Cache-Control", "no-cache");
		 *
		 *
		 * if (logger.isInfoEnabled()) { logger.info("xml=" + xml);
		 * logger.info("content type : " + response.getContentType()); }
		 *
		 *
		 * // write the bytes to the response response.getWriter().write(xml);
		 */
	}
}

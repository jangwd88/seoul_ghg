package egovframework.seoul.view;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.view.AbstractView;

import antlr.StringUtils;
import twitter4j.JSONArray;
import twitter4j.JSONObject;


@SuppressWarnings("all")
public class JSONView extends AbstractView {

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
	}

	/** Logger for this class *//*
	protected final Logger logger = LoggerFactory.getLogger(getClass());

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	protected void renderMergedOutputModel(Map map, HttpServletRequest request, HttpServletResponse response)
	throws Exception {
		// TODO Auto-generated method stub
		boolean isArray = false;

		Object model = null;
		boolean combo = false;

		if (map.get("AJAX_MODEL") != null ) {
			model = map.get("AJAX_MODEL");

		} else if ( map.get("gridList") != null ) {
			Map pageMap = new HashMap();
			List list = (ArrayList)map.get("gridList");

			pageMap.put("rows", 	list);
			pageMap.put("total", 	1);
			pageMap.put("pagesize", 1);
			pageMap.put("page", 	1);
			pageMap.put("records", 	list.size());

			model = pageMap;

		} else if ( map.get("pageGridList") != null ) {
			Map pageMap = new HashMap();
			PaginatedArrayList list = (PaginatedArrayList)map.get("pageGridList");

			pageMap.put("rows", 	list);
			pageMap.put("total", 	list.getTotalPage());
			pageMap.put("pagesize", list.getPageSize());
			pageMap.put("page", 	list.getCurrPage());
			pageMap.put("records", 	list.getTotalSize());

			model = pageMap;

		} else if (map.get("COMBO_MODEL") != null) {
			combo = true;
			model = map.get("COMBO_MODEL");

		} else {
			model = map;

		}


		JSONObject jsonObject = null;
		JSONArray  jsonArray =  null;

		if (!combo) {
			if (model != null  ) {
				if (model instanceof java.util.List) {
					isArray = true;
					jsonArray = JSONArray.fromObject( model );
				}
				else {
					jsonObject = JSONObject.fromObject( model );
				}
			} else {
				// so render entire map
				jsonObject = JSONObject.fromObject( null );
			}
		}

		// -------------------------------- write the bytes to the response
		// response.getOutputStream().write(xml.getBytes());
		// -------------------------------- set header info default to text/xml
		if (StringUtils.isEmpty(getContentType())) {
			setContentType("text/json;charset=utf-8");
		}
		response.setContentType("text/json;charset=utf-8");
		// tell browser not to cache response
		response.setHeader("Cache-Control", "no-cache");

		if (isArray) {
			response.getWriter().write(jsonArray.toString());

			if (logger.isInfoEnabled()) {
				logger.info("JSON ARRAY !!!!!!");
				logger.info("json=" + jsonArray.toString());
				logger.info("content type : " + response.getContentType());
			}

		}
		else {
			if (!combo) {
				response.getWriter().write(jsonObject.toString() );

				if (logger.isInfoEnabled()) {
					logger.info("JSON OBJECT !!!!!!");
					logger.info("json=" + jsonObject.toString());
					logger.info("content type : " + response.getContentType());
				}
			} else {
				response.getWriter().write(model.toString() );

				if (logger.isInfoEnabled()) {
					logger.info("JSON OBJECT !!!!!!");
					logger.info("json=" + model.toString());
					logger.info("content type : " + response.getContentType());
				}
			}
		}
	}*/

}

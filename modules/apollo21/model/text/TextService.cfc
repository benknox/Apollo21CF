component extends="coldbox.system.orm.hibernate.VirtualEntityService" singleton{

	/**
	* Constructor
	*/
	public TextService function init(){

		// init super class
		super.init(entityName="Text");

	    return this;
	}
}
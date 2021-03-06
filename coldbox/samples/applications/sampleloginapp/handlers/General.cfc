<!-----------------------------------------------------------------------Author 	 :	Your NameDate     :	September 25, 2005Description :	coldboxSamples.system.eventhandler-----------------------------------------------------------------------><cfcomponent name="General" extends="coldbox.system.EventHandler">	<!--- ************************************************************* --->	<cffunction name="onRequestStart" access="public" returntype="void" output="false">		<cfargument name="Event" type="any">		<!---		Security Check		You need to check for the doLogin method, beacuse, if not, the doLogin method		will never get a chance to be called.		So check if the session.loggedin flag exists or not true, and if we		are not logging in.		--->		<cfscript>			var rc = Event.getCollection();			//Set xeh's			rc.xehLogout = "General.doLogout";			rc.xehHome = "General.Home";		</cfscript>	</cffunction>	<!--- ************************************************************* --->	<!--- ************************************************************* --->	<cffunction name="Login" access="public" returntype="void" output="false">		<cfargument name="Event" type="any">		<cfscript>			var rc = Event.getCollection();			//Set xeh's			rc.xehLogin = "General.doLogin";			//Set the page's title			Event.setValue("title", "ColdBox - Sample Login App: Login page");			/*				The view "general/login" will be used by convention for this event				because of the handler name "general" and the event name "login".				Alternatly, you can manually set the view using				Event.setView("general/login");			*/		</cfscript>	</cffunction>	<!--- ************************************************************* --->	<!--- ************************************************************* --->	<cffunction name="doLogin" access="public" returntype="void" output="false">		<cfargument name="Event" type="any">		<cfscript>			//Do Login Procedure.			var objDataStore = "";			var rc = Event.getCollection();			var ValidationStruct = "";			//Error checks, does the form variables username & password exist			//in the request collection? if they do, are they blank?			if( not Event.valueExists("username") or not Event.valueExists("password") ){				//Set a message to display				getPlugin("MessageBox").setMessage("error","No username or password defined.");				getPlugin("Logger").logEntry("error","Login without variables set detected.");				//Redirect to next event, you can also add extra parameters to the URL				setNextEvent("General.Login","username=#Event.getValue("username","")#");			}			else{				//Init DataStorage				objDataStore = CreateObject("component","#getSetting("AppMapping")#.model.datastore").init();				ValidationStruct = objDataStore.validateUser(rc.username, rc.password);				if ( ValidationStruct.validated ){					//Login Correct.					//set my session vars					getPlugin("SessionStorage").setVar("loggedin",true);					getPlugin("SessionStorage").setVar("name",ValidationStruct.qUser.name);					//Log the entry					getPlugin("Logger").logEntry("information","The user #validationStruct.qUser.name# has now logged in.");					//relocate to home page.					setNextEvent("General.Home");				}				else{					//Set a message to display					getPlugin("MessageBox").setMessage("error","Invalid Logon Information. Please try again");					getPlugin("Logger").logEntry("warning","Invalid logon information detected. IP used: #cgi.remote_addr#");					//Redirect to next event, you can also add extra parameters to the URL					setNextEvent("General.Login","username=#Event.getValue("username")#");				}			}		</cfscript>	</cffunction>	<!--- ************************************************************* --->	<!--- ************************************************************* --->	<cffunction name="Home" access="public" returntype="void" output="false">		<cfargument name="Event" type="any">		<cfscript>			//Set the page's title			Event.setValue("title", "Sample Login App: Welcome Back");			/*				The view "general/home" will be used by convention for this event				because of the handler name "general" and the event name "home".				Alternatly, you can manually set the view using				Event.setView("general/home");			*/		</cfscript>	</cffunction>	<!--- ************************************************************* --->	<!--- ************************************************************* --->	<cffunction name="doLogout" access="public" returntype="void" output="false">		<cfargument name="Event" type="any">		<cfscript>			//Delete login Information			getPlugin("SessionStorage").clearAll();			//Set the next event to display			setNextEvent("General.Login");		</cfscript>	</cffunction>	<!--- ************************************************************* ---></cfcomponent>
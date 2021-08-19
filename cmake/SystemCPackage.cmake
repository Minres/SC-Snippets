# a small wrapper to map SLS, OSCI SystemC (from environment) and conan package to the same variables
if(NOT SystemC_FOUND)
	if(USE_CWR_SYSTEMC)
	    find_package(SLSSystemC REQUIRED)
	elseif(USE_NCSC_SYSTEMC)
	    find_package(XMSystemC REQUIRED)
	else()
	    find_package(SystemCLanguage QUIET)
	    if(TARGET SystemC::systemc) # conan find_package_generator or the cmake of an SystemC installation
	        set(SystemC_FOUND true)
	        set(SystemC_LIBRARIES SystemC::systemc)
	        find_package(systemc-scv QUIET)
	        if(systemc-scv_FOUND)
	            set(SCV_FOUND TRUE)
	            set(SCV_LIBRARIES systemc-scv::systemc-scv)
	        endif()
	        find_package(systemc-cci QUIET)
	        if(systemc-cci_FOUND)
	            set(CCI_FOUND TRUE)
	            set(CCI_LIBRARIES systemc-cci::systemc-cci)
	        endif()
	    elseif(TARGET CONAN_PKG::systemc) # conan cmake targets
	        set(SystemC_FOUND true)
	        set(SystemC_LIBRARIES CONAN_PKG::systemc)
	        if(TARGET CONAN_PKG::systemc-scv)
	            set(SCV_FOUND TRUE)
	            set(SCV_LIBRARIES CONAN_PKG::systemc-scv)
	        endif()
	        if(TARGET CONAN_PKG::systemc-cci)
	            set(CCI_FOUND TRUE)
	            set(CCI_LIBRARIES CONAN_PKG::systemc-cci)
	        endif()
	    else()
	        find_package(OSCISystemC)
            set(SystemC_LIBRARIES SystemC::systemc)
	    endif()
	endif()
endif()
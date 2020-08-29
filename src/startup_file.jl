const PLUGINS = first.(splitext.([
	GMAT_jll.libgmatephempropagator_path,
	GMAT_jll.libgmatformation_path,
	GMAT_jll.libgmatproductionpropagators_path,
	GMAT_jll.libgmatthrustfile_path,
	GMAT_jll.libgmatcinterface_path,
	GMAT_jll.libgmatestimation_path,
	GMAT_jll.libgmatfunction_path,
	GMAT_jll.libgmatsavecommand_path,
	GMAT_jll.libgmatdatainterface_path,
	GMAT_jll.libgmateventlocator_path,
	GMAT_jll.libgmatnewparameters_path,
	GMAT_jll.libgmatscripttools_path,
	GMAT_jll.libgmatyukonoptimizer_path,
	GMAT_jll.libgmatekf_path,
	GMAT_jll.libgmatextrapropagators_path,
	GMAT_jll.libgmatpolyhedrongravity_path,
	GMAT_jll.libgmatstation_path,
]))

function startup_file(data_path, output_path)
	return """
#-------------------------------------------------------------------------------
# General Mission Analysis Tool (GMAT) startup file
#-------------------------------------------------------------------------------
# Comment lines start with #
#
# Path/file naming conventions:
#   - Path name properties end with _PATH and can be referenced elsewhere in the
#     file
#   - File name properties end with _FILE
#   - Path/file names are case sensitive on Linux and OS X
#   - Relative paths are relative to the GMAT executable or application bundle
#     (on OS X)
#
# You can add potential and texture files by following the naming convention:
#   - Potential file properties should begin with celestial body name and end
#     with _POT_FILE
#   - Texture file properties should begin with celestial body name and end
#     with _TEXTURE_FILE
#
# If same _FILE is specified multiple times, the last entry will be used.
#
# You can have multiple GMAT_FUNCTION_PATH, MATLAB_FUNCTION_PATH, or
# PYTHON_MODULE_PATH lines. GMAT will search the paths in top-to-bottom order
# and use the first function file found.
#
# In order for a plugin to work, the path to the plugin library for Windows
# (.dll), Linux (.so) or OS X (.dylib) must be specified in a PLUGIN line below.
# The plugin name should be specified without the file extension. Plugins are
# loaded in the order listed.
#
#===============================================================================

#-----------------------------------------------------------
# Runtime options
#-----------------------------------------------------------
#MATLAB_MODE             = SINGLE
#MATLAB_MODE             = SHARED
#MATLAB_MODE             = NO_MATLAB
#WRITE_GMAT_KEYWORD      = ON
#WRITE_PERSONALIZATION_FILE = ON
#NO_SPLASH               = TRUE
#ECHO_COMMANDS           = TRUE

#-----------------------------------------------------------
# Plugins
#-----------------------------------------------------------
$(join("PLUGIN = " .* PLUGINS, "\n"))

#-----------------------------------------------------------
# Directory/file paths
#-----------------------------------------------------------

# Occasional issues have been observed on Windows in which
# GMAT cannot find certain data files, such as icons and DE
# files, at runtime. If this occurs, set ROOT_PATH to the
# absolute path to your top-level GMAT directory.

ROOT_PATH                = $(pwd())

#-----------------------------------------------------------
OUTPUT_PATH              = $output_path
LOG_FILE                 = OUTPUT_PATH/GmatLog.txt
SCREENSHOT_FILE          = OUTPUT_PATH/GmatScreenShot
#-----------------------------------------------------------
MEASUREMENT_PATH         = OUTPUT_PATH/
#-----------------------------------------------------------
VEHICLE_EPHEM_PATH       = OUTPUT_PATH/
#-----------------------------------------------------------
GMAT_INCLUDE_PATH        = ROOT_PATH/userincludes/
#-----------------------------------------------------------
GMAT_FUNCTION_PATH       = ROOT_PATH/userfunctions/gmat
#-----------------------------------------------------------
MATLAB_FUNCTION_PATH     = ROOT_PATH/matlab
MATLAB_FUNCTION_PATH     = ROOT_PATH/userfunctions/matlab
#-----------------------------------------------------------
PYTHON_MODULE_PATH       = ROOT_PATH/userfunctions/python
#-----------------------------------------------------------
DATA_PATH                = $data_path
FILE_UPDATE_PATH         = $data_path
#-----------------------------------------------------------
PLANETARY_EPHEM_SPK_PATH = DATA_PATH/planetary_ephem/spk/
PLANETARY_SPK_FILE       = PLANETARY_EPHEM_SPK_PATH/DE421AllPlanets.bsp
#-----------------------------------------------------------
PLANETARY_EPHEM_DE_PATH  = DATA_PATH/planetary_ephem/de/
DE405_FILE               = PLANETARY_EPHEM_DE_PATH/leDE1941.405
DE421_FILE               = PLANETARY_EPHEM_DE_PATH/leDE1900.421
DE424_FILE               = PLANETARY_EPHEM_DE_PATH/leDE18002100.424
#-----------------------------------------------------------
VEHICLE_EPHEM_SPK_PATH   = DATA_PATH/vehicle/ephem/spk/
VEHICLE_EPHEM_CCSDS_PATH = DATA_PATH/vehicle/ephem/ccsds/
#-----------------------------------------------------------
PLANETARY_COEFF_PATH     = DATA_PATH/planetary_coeff/
EOP_FILE                 = PLANETARY_COEFF_PATH/eopc04_08.62-now
NUTATION_COEFF_FILE      = PLANETARY_COEFF_PATH/NUTATION.DAT
PLANETARY_PCK_FILE       = PLANETARY_COEFF_PATH/SPICEPlanetaryConstantsKernel.tpc
EARTH_LATEST_PCK_FILE  = PLANETARY_COEFF_PATH/earth_latest_high_prec.bpc
EARTH_PCK_PREDICTED_FILE = PLANETARY_COEFF_PATH/SPICEEarthPredictedKernel.bpc
EARTH_PCK_CURRENT_FILE   = PLANETARY_COEFF_PATH/SPICEEarthCurrentKernel.bpc
LUNA_PCK_CURRENT_FILE    = PLANETARY_COEFF_PATH/SPICELunaCurrentKernel.bpc
LUNA_FRAME_KERNEL_FILE   = PLANETARY_COEFF_PATH/SPICELunaFrameKernel.tf
#-----------------------------------------------------------
TIME_PATH                = DATA_PATH/time/
LEAP_SECS_FILE           = TIME_PATH/tai-utc.dat
LSK_FILE                 = TIME_PATH/SPICELeapSecondKernel.tls
#-----------------------------------------------------------
EARTH_POT_PATH           = DATA_PATH/gravity/earth/
LUNA_POT_PATH            = DATA_PATH/gravity/luna/
MARS_POT_PATH            = DATA_PATH/gravity/mars/
VENUS_POT_PATH           = DATA_PATH/gravity/venus/
OTHER_POT_PATH           = DATA_PATH/gravity/other/
#-----------------------------------------------------------
EGM96_FILE               = EARTH_POT_PATH/EGM96.cof
JGM2_FILE                = EARTH_POT_PATH/JGM2.cof
JGM3_FILE                = EARTH_POT_PATH/JGM3.cof
MARS50C_FILE             = MARS_POT_PATH/Mars50c.cof
MGNP180U_FILE            = VENUS_POT_PATH/MGNP180U.cof
LP165P_FILE              = LUNA_POT_PATH/LP165P.cof
#-----------------------------------------------------------
GUI_CONFIG_PATH          = DATA_PATH/gui_config/
PERSONALIZATION_FILE     = GUI_CONFIG_PATH/MyGmat.ini
#-----------------------------------------------------------
ICON_PATH                = DATA_PATH/graphics/icons/
MAIN_ICON_FILE           = ICON_PATH/GMATWin32.ico
#-----------------------------------------------------------
SPLASH_PATH              = DATA_PATH/graphics/splash/
SPLASH_FILE              = SPLASH_PATH/GMATSplashScreenBETA.png
#-----------------------------------------------------------
TEXTURE_PATH             = DATA_PATH/graphics/texture/
SUN_TEXTURE_FILE         = TEXTURE_PATH/Sun.jpg
MERCURY_TEXTURE_FILE     = TEXTURE_PATH/Mercury_JPLCaltech.jpg
VENUS_TEXTURE_FILE       = TEXTURE_PATH/Venus_BjornJonsson.jpg
EARTH_TEXTURE_FILE       = TEXTURE_PATH/ModifiedBlueMarble.jpg
LUNA_TEXTURE_FILE        = TEXTURE_PATH/Moon_HermesCelestiaMotherlode.jpg
MARS_TEXTURE_FILE        = TEXTURE_PATH/Mars_JPLCaltechUSGS.jpg
JUPITER_TEXTURE_FILE     = TEXTURE_PATH/Jupiter_HermesCelestiaMotherlode.jpg
SATURN_TEXTURE_FILE      = TEXTURE_PATH/Saturn_gradiusCelestiaMotherlode.jpg
URANUS_TEXTURE_FILE      = TEXTURE_PATH/Uranus_JPLCaltech.jpg
NEPTUNE_TEXTURE_FILE     = TEXTURE_PATH/Neptune_BjornJonsson.jpg
PLUTO_TEXTURE_FILE       = TEXTURE_PATH/Pluto_JPLCaltech.jpg
#-----------------------------------------------------------
BODY_3D_MODEL_PATH       = DATA_PATH/graphics/models/
#-----------------------------------------------------------
STAR_PATH                = DATA_PATH/graphics/stars/
STAR_FILE                = STAR_PATH/inp_StarCatalog.txt
CONSTELLATION_FILE       = STAR_PATH/inp_Constellation.txt
BORDER_FILE              = STAR_PATH/inp_Border.txt
#-----------------------------------------------------------
VEHICLE_MODEL_PATH       = DATA_PATH/vehicle/models/
SPACECRAFT_MODEL_FILE    = VEHICLE_MODEL_PATH/aura.3ds
#-----------------------------------------------------------
SPAD_PATH                = DATA_PATH/vehicle/spad/
SPAD_SRP_FILE            = SPAD_PATH/SphericalModel.spo
#-----------------------------------------------------------
ATMOSPHERE_PATH          = DATA_PATH/atmosphere/earth
CSSI_FLUX_FILE           = ATMOSPHERE_PATH/SpaceWeather-All-v1.2.txt
SCHATTEN_FILE            = ATMOSPHERE_PATH/SchattenPredict.txt
MARINI_TROPO_FILE        = ATMOSPHERE_PATH/marini.dat
#-----------------------------------------------------------
HELP_FILE                = ROOT_PATH/docs/help/help.chm
#-----------------------------------------------------------
ICRF_FILE                = DATA_PATH/icrf/ICRF_Table.txt
#-----------------------------------------------------------

#-----------------------------------------------------------
# Debug options
#-----------------------------------------------------------
#RUN_MODE                 = TESTING
#RUN_MODE                 = TESTING_NO_PLOTS
#RUN_MODE                 = EXIT_AFTER_RUN
#DEBUG_MATLAB             = ON
#DEBUG_PARAMETERS         = ON
#DEBUG_FILE_PATH          = ON
#HIDE_SAVEMISSION         = TRUE
#PLOT_MODE                = TILE
"""
end

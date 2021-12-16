//====================//
// Activate Codes.
//====================//

#if defined _activate_codes_included
	#endinput
#endif

/**
 *	Returns the flag in ADMFLAG format if the code is correct.
 *
 *	@param	code	The code string.
 *
 *	@return	Returns the flag in ADMFLAG format, else 0.
 */
native int ActivateCodes_GetFlagFromCode(const char[] code);

public SharedPlugin __pl_activate_codes =
{
	name = "ActivateCodes",
	file = "activate_codes.smx",
#if defined REQUIRE_PLUGIN
	required = 1,
#else
	required = 0,
#endif
}

#if !defined REQUIRE_PLUGIN
public void __pl_activate_codes_SetNTVOptional()
{
	MarkNativeAsOptional("ActivateCodes_GetFlagFromCode");
}
#endif
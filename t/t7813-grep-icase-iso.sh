#!/bin/sh

test_description='grep icase on non-English locales'

. ./lib-gettext.sh

test_expect_success GETTEXT_ISO_LOCALE 'setup' '
	printf "TILRAUN: Halló Heimur!" >file &&
	git add file &&
	LC_ALL="$is_IS_iso_locale" &&
	export LC_ALL
'

for pcrev in 1 2
do
	test_expect_success GETTEXT_ISO_LOCALE,LIBPCRE$pcrev "grep -i with i18n string using libpcre$pcrev" "
		git -c grep.patternType=pcre$pcrev grep -i \"TILRAUN: H.lló Heimur!\" &&
		git -c grep.patternType=pcre$pcrev grep -i \"TILRAUN: H.LLÓ HEIMUR!\"
	"
done

test_done

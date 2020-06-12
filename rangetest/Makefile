#
# ADAPTED TO POINT TO 212b for samr30-xpro
RIOTBASE=$(HOME)/RIOT
BOARD=samr30-xpro
# IMPORTANT to set 868MHz page (0 or 2) and a power (0-36)
CFLAGS += -DCONFIG_IEEE802154_DEFAULT_TXPOWER=36
CFLAGS += -DCONFIG_IEEE802154_DEFAULT_SUBGHZ_CHANNEL=0
# Does NOT work with PAGE 2 for some reason!
CFLAGS += -DCONFIG_IEEE802154_DEFAULT_SUBGHZ_PAGE=0
include $(RIOTBASE)/tests/Makefile.tests_common

DISABLE_MODULE += auto_init_at86rf2xx
USEMODULE += xtimer
USEMODULE += od
USEMODULE += shell
USEMODULE += shell_commands
USEMODULE += ps

# define the driver to be used for selected boards
ifneq (,$(filter samr21-xpro,$(BOARD)))
  DRIVER := at86rf233
endif
ifneq (,$(filter sam30-xpro,$(BOARD)))
  DRIVER := at86rf212b
endif

# use the at86rf212b as fallback device
DRIVER ?= at86rf212b

# include the selected driver
USEMODULE += $(DRIVER)

include $(RIOTBASE)/Makefile.include

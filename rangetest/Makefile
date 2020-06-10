#
# ADAPTED TO POINT TO 212b for samr30-xpro
RIOTBASE=/home/km/RIOT
BOARD=samr30-xpro
#CONFIG_IEEE802154_DEFAULT_TXPOWER=1
CFLAGS += -DIEEE802154_DEFAULT_SUBGHZ_CHANNEL=0
CFLAGS += -DIEEE802154_DEFAULT_SUBGHZ_PAGE=0
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
ifneq (,$(filter iotlab-m3 fox,$(BOARD)))
  DRIVER := at86rf231
endif
ifneq (,$(filter sam30-xpro,$(BOARD)))
  DRIVER := at86rf212b
endif

# use the at86rf231 as fallback device
DRIVER ?= at86rf231

# include the selected driver
USEMODULE += $(DRIVER)

include $(RIOTBASE)/Makefile.include

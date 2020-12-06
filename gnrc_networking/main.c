/* version of gnrc_networking with enforced rpl on interface 6
and external antenna on xpro boards
*/
/*
 * Copyright (C) 2015 Freie Universität Berlin
 *
 * This file is subject to the terms and conditions of the GNU Lesser
 * General Public License v2.1. See the file LICENSE in the top level
 * directory for more details.
 */

/**
 * @ingroup     examples
 * @{
 *
 * @file
 * @brief       Example application for demonstrating the RIOT network stack
 *
 * @author      Hauke Petersen <hauke.petersen@fu-berlin.de>
 *
 * @}
 */

#include <stdio.h>

#include "shell.h"
#include "msg.h"
#include "board.h"
/* included so we can initialise RPL */
#include "net/gnrc/rpl.h"
#include "net/gnrc/rpl/structs.h"
#include "net/gnrc/rpl/dodag.h"


#define MAIN_QUEUE_SIZE     (8)
static msg_t _main_msg_queue[MAIN_QUEUE_SIZE];

extern int udp_cmd(int argc, char **argv);

static const shell_command_t shell_commands[] = {
    { "udp", "send data over UDP and listen on UDP ports", udp_cmd },
    { NULL, NULL, NULL }
};

int main(void)
{
    /* we need a message queue for the thread running the shell in order to
     * receive potentially fast incoming networking packets */
    board_antenna_config(RFCTL_ANTENNA_EXT);
    msg_init_queue(_main_msg_queue, MAIN_QUEUE_SIZE);
    puts("RIOT network stack example application with 868MHz page0 manual rpl init");
   puts("Waiting for address autoconfiguration...");
    xtimer_sleep(3);
    /* Quick hack to start RPL properly. Fixed interface Num for now 
    */
    gnrc_rpl_init(6);
   puts("RPL initialised ...");

    /* start shell */
    puts("All up, running the shell now");
    char line_buf[SHELL_DEFAULT_BUFSIZE];
    shell_run(shell_commands, line_buf, SHELL_DEFAULT_BUFSIZE);

    /* should be never reached */
    return 0;
}

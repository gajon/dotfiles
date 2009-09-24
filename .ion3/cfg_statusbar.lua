--
-- Ion statusbar module configuration file
-- vim: set sw=4 sts=4 expandtab:
--


-- Create a statusbar
mod_statusbar.create{
    -- First screen, bottom left corner
    screen=0,
    pos='bl',
    -- Set this to true if you want a full-width statusbar
    fullsize=false,
    -- Swallow systray windows
    systray=true,

    -- Template. Tokens %string are replaced with the value of the 
    -- corresponding meter. Currently supported meters are:
    --   date          date
    --   load          load average (1min, 5min, 15min)
    --   load_Nmin     N minute load average (N=1, 5, 15)
    --   mail_new      mail count (mbox format file $MAIL)
    --   mail_unread   mail count
    --   mail_total    mail count
    --   mail_*_new    mail count (from an alternate mail folder, see below)
    --   mail_*_unread mail count
    --   mail_*_total  mail count
    --
    -- Space preceded by % adds stretchable space for alignment of variable
    -- meter value widths. > before meter name aligns right using this 
    -- stretchable space , < left, and | centers.
    -- Meter values may be zero-padded to a width preceding the meter name.
    -- These alignment and padding specifiers and the meter name may be
    -- enclosed in braces {}.
    --
    -- %filler causes things on the marker's sides to be aligned left and
    -- right, respectively, and %systray is a placeholder for system tray
    -- windows and icons.
    --
    --template="[ %date || load:% %>load || mail:% %>mail_new/%>mail_total ] %filler%systray",
    --template="[ %date || load: %05load_1min || mail: %02mail_new/%02mail_total ] %filler%systray",
    template="[ %exec_date || %load || /home %exec_homefree || %netmon_kbsin/%netmon_kbsout (%netmon_avgin/%netmon_avgout) || vol: %exec_vol ] %exec_music %filler%systray",
}


-- Launch ion-statusd. This must be done after creating any statusbars
-- for necessary statusd modules to be parsed from the templates.
mod_statusbar.launch_statusd{
    -- Date meter
    date={
        -- ISO-8601 date format with additional abbreviated day name
        date_format='%a %Y-%m-%d %H:%M',
        -- Finnish etc. date format
        --date_format='%a %d.%m.%Y %H:%M',
        -- Locale date format (usually shows seconds, which would require
        -- updating rather often and can be distracting)
        --date_format='%c',

        -- Additional date formats. 
        --[[ 
        formats={ 
            time = '%H:%M', -- %date_time
        }
        --]]
    },

    -- Load meter
    load={
        --update_interval=10*1000,
        --important_threshold=1.5,
        --critical_threshold=4.0,
    },

    -- Mail meter
    --
    -- To monitor more mbox files, add them to the files table.  For
    -- example, add mail_work_new and mail_junk_new to the template
    -- above, and define them in the files table:
    --
    -- files = { work = "/path/to/work_email", junk = "/path/to/junk" }
    --
    -- Don't use the keyword 'spool' as it's reserved for mbox.
    mail={
        --update_interval=60*1000,
        --mbox=os.getenv("MAIL"),
        --files={},
    },

    --df={
    --    template = "%mpoint %avail(%availp) free",
    --    fslist = { "/home" },
    --    separator = "  ",
    --    update_interval = 60000,
    --},

    exec = {
        date = {
            program = 'date "+%a %Y-%m-%d %H:%M"',
            retry_delay = 1000,
            hint_regexp = {
                important = {'14:..$',},
                critical = {'15:..$'},
            },
        },

        music = {
            --program = 'rhythmbox-client --no-start --no-present --print-playing',
            program = 'mpc | head -1',
            retry_delay = 2 * 1000,
        },

        homefree = {
            program = 'df|grep sdb3|sed "s/.*\\(..%\\).*/\\1/"',
            retry_delay = 60 * 1000,
            meter_length = 4,
            hint_regexp = {
                important = '9[456].',
                critical = {
                    '9[789].',
                    '1...',
                },
            },
        },

        vol = {
            program = 'aumix -q|grep vol|sed "s/vol \\([0-9]*\\),.*/\\1%/"',
            retry_delay = 1*1000,
            hint_regexp = {
                important = {'5..', '6..', '7..'},
                critical = {'8..', '9..', '1...',},
            },
        },
    },

    netmon = {
        device = "eth0",
        show_avg = 1,       -- show average stat?
        avg_sec = 60,       -- default, shows average of 1 minute
        show_count = 0,     -- show tcp connection count?
        interval = 1*1000,  -- update every second
        important = {
            kbsin = 50,
            kbsout = 2,
            avgin = 40,
            avgout = 1,
            count = 4,
        },
        critical = {
            kbsin = 100,
            kbsout = 5,
            avgin = 70,
            avgout = 3,
            count = 50,
        }
    },

}


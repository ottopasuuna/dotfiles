local items = {}

items.mapp = {}
items.mapp["Network"] = {
    icon = "network.svg",
    items = {
        { name="Firefox",                  command="firefox",              icon="firefox.png"     },
        { name="Wireshark",                command="wireshark",            icon="wireshark.png"   },
        { name="ZenMap",                   command="zenmap",               icon="zenmap.png"      },
        { name="Thunderbird",              command="thunderbird",          icon="thunderbird.png" }
    }
}
items.mapp["Development"] = {
    icon = "development.svg",
    items = {
        { name="gdb promp",                command="prompt_gdb",           icon="gdb.png"         },
        { name="Python shell",             command="prompt_python",        icon="python.png"      },
        { name="Perl shell",               command="prompt_perl",          icon="perl.png"        },
        { name="Valkyrie",                 command="valkyrie",             icon="valkyrie.png"    },
        { name="Massif visualizer",        command="massif-visualizer",    icon="massif.png"      }
    }
}
items.mapp["Messenger"] = {
    icon = "messenger.svg",
    items = {
        { name="Psi",                      command="psi",                  icon="psi.png"         }
    }
}
items.mapp["Reader"] = {
    icon = "reader.svg",
    items = {
        { name="QuiteRSS",                 command="quiterss",             icon="quiterss.png"    },
        { name="Ebook Reader",             command="qpdfview",             icon="ebook.png"       },
        { name="Deskzilla",                command="deskzilla",            icon="deskzilla.png"   }
    }
}
items.mapp["Graphics"] = {
    icon = "graphics.svg",
    items = {
        { name="Gimp",                     command="gimp-2.8",             icon="gimp.png"        },
        { name="XnView",                   command="xnview",               icon="xnview.png"      },
        { name="yEd Graph Editor",         command="yEd",                  icon="yed.png"         },
        { name="Visual Color Picker",      command="vcp",                  icon="colors.png"      }
    }
}
items.mapp["Multimedia"] = {
    icon = "multimedia.svg",
    items = {
        { name="Record Desktop",           command="qx11grab",             icon="record.png"      },
        { name="Jack control",             command="qjackctl",             icon="qjackctl.png"    },
        { name="Ardour",                   command="ardour3",              icon="ardour.png"      },
        { name="Sound Mixer",              command="mixtray",              icon="alsa.png"        }
    }
}
items.mapp["Office"] = {
    icon = "office.svg",
    items = {
        { name="Thunderbird",              command="thunderbird",          icon="thunderbird.png" }
    }
}
items.mapp["System"] = {
    icon = "system.svg",
    items = {
        { name="Nvidia Settings",          command="nvidia-settings",      icon="nvidia.png"      },
        { name="VirtualBox",               command="virtualbox",           icon="virtualbox.png"  },
        { name="Process Manager",          command="qps",                  icon="system.png"      },
        { name="GParted",                  command="gparted",              icon="gparted.png"     },
        { name="Screensaver",              command="xscreensaver-demo",    icon="screen.png"      }
    }
}
items.mapp["Utilities"] = {
    icon = "utilities.svg",
    items = {
        { name="Terminal",                 command="urxvt",                icon="terminal.svg"    }
    }
}

-- Quick menu table.
items.qapp = {}
items.qapp["Terminal"]     = { command="urxvt",       key="t", icon="terminal.svg",         tag=1 }
items.qapp["File Manager"] = { command="krusader",    key="f", icon="file-manager.svg",     tag=4 }
items.qapp["Web browser"]  = { command="firefox",     key="w", icon="browser.svg",          tag=2 }
items.qapp["Editor"]       = { command="emacs",       key="e", icon="editor.svg",           tag=1 }
items.qapp["Thunderbird"]  = { command="thunderbird", key="q", icon="thunderbird.svg",      tag=6 }
items.qapp["IDE"]          = { command="vs",          key="d", icon="IDE.svg",              tag=3 }
items.qapp["Irc Client"]   = { command="kvirc4",      key="c", icon="irc.svg",              tag=5 }
items.qapp["Calculator"]   = { command="speedcrunch", key="k", icon="calculator.svg",       tag=0 }
items.qapp["Task Manager"] = { command="qps",         key="p", icon="proc.svg",             tag=0 }

return items

all: install

install:
	mkdir -p $(DESTDIR)/usr/share/kde4/apps/plasma/plasmoids/
	@cp -fr tr.org.etap.appsmenu $(DESTDIR)/usr/share/kde4/apps/plasma/plasmoids/

	mkdir -p $(DESTDIR)/usr/share/kde4/services
	@cp -fr eta-widget-appsmenu.desktop $(DESTDIR)/usr/share/kde4/services/

uninstall:
	@rm -fr $(DESTDIR)/usr/share/kde4/services/eta-widget-appsmenu.desktop
	@rm -fr $(DESTDIR)/usr/share/kde4/apps/plasma/plasmoids/tr.org.etap.appsmenu

.PHONY: install uninstall

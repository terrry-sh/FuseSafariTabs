# Makefile for FuseSafariTabs

TARGET = FuseSafariTabs
SWIFT_SOURCE = FuseSafariTabs.swift
SWIFT_FLAGS = -O -suppress-warnings

all: $(TARGET)

$(TARGET): $(SWIFT_SOURCE)
	swiftc $(SWIFT_FLAGS) -o $(TARGET) $(SWIFT_SOURCE)
	@echo "✅ Binary created: $(TARGET)"

run: $(TARGET)
	./$(TARGET)

clean:
	rm -f $(TARGET)
	@echo "🗑️  Cleaned build artifacts"

install: $(TARGET)
	@mkdir -p /usr/local/bin
	@cp $(TARGET) /usr/local/bin/
	@echo "📦 Installed to /usr/local/bin/$(TARGET)"

uninstall:
	@rm -f /usr/local/bin/$(TARGET)
	@echo "🗑️  Uninstalled from /usr/local/bin/$(TARGET)"

.PHONY: all run clean install uninstall
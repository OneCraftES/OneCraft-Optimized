#!/usr/bin/env bash
# Should be ran from the pre-launch command in instance's settings.
# Edits by RaptaG (https://github.com/RaptaG)

# Function to check system memory and adjust JVM args
get_memory_settings() {
	# Get total physical memory in GB
	if [ "$(uname)" = "Darwin" ]; then
		# macOS
		total_memory_gb=$(($(sysctl -n hw.memsize) / 1024 / 1024 / 1024))
	else
		# Linux and similar
		total_memory_gb=$(($(grep MemTotal /proc/meminfo | awk '{print $2}') / 1024 / 1024))
	fi
	echo "Total System Memory: $total_memory_gb GB"
	
	# Calculate recommended memory allocation
	if [ "$total_memory_gb" -le 4 ]; then
		# Low-end systems (≤4GB)
		min_mem=1024
		max_mem=2048
		echo "Low memory system detected. Adjusting memory allocation..."
	elif [ "$total_memory_gb" -le 8 ]; then
		# Medium systems (5-8GB)
		min_mem=2048
		max_mem=4096
		echo "Medium memory system detected. Using moderate memory allocation..."
	elif [ "$total_memory_gb" -le 16 ]; then
		# High-end systems (9-16GB)
		min_mem=4096
		max_mem=8192
		echo "High memory system detected. Using recommended memory allocation..."
	else
		# Very high-end systems (>16GB)
		min_mem=8192
		max_mem=12288
		echo "High-end system detected. Using maximum memory allocation..."
	fi

	# Update instance configuration if it exists
	for cfg_path in \
		./instance.cfg \
		../instance.cfg; do
		if [ -f "$cfg_path" ]; then
			sed -i.bak -e "s/MinMemAlloc=[0-9]*/MinMemAlloc=$min_mem/" \
					  -e "s/MaxMemAlloc=[0-9]*/MaxMemAlloc=$max_mem/" "$cfg_path"
			rm -f "${cfg_path}.bak"
			echo "Updated memory settings in $cfg_path"
			break
		fi
	done
}

# Function to download and extract Distant Horizons
get_distant_horizons() {
	version=$1
	# Check if version is supported
	case "$version" in
		"1.21"|"1.21.1"|"1.21.3"|"1.21.4")
			;;
		*)
			echo "Warning: Distant Horizons is not supported for Minecraft $version"
			return 1
			;;
	esac

	echo "Downloading Distant Horizons for Minecraft $version..."
	# Use 1.21.1 build for 1.21 and 1.21.1
	if [ "$version" = "1.21" ] || [ "$version" = "1.21.1" ]; then
		build_version="1.21.1"
	else
		build_version="$version"
	fi
	
	url="https://gitlab.com/distant-horizons-team/distant-horizons/-/jobs/artifacts/main/download?job=build:%20[$build_version]"
	zip_file="dh-$version.zip"
	
	# Download and extract
	if curl -L "$url" -o "$zip_file"; then
		rm -rf temp-dh
		if unzip "$zip_file" -d temp-dh; then
			jar_file=$(find temp-dh/fabric/build/libs -name "distanthorizons-*.jar" | head -n 1)
			if [ -n "$jar_file" ]; then
				mv "$jar_file" "mods/distanthorizons-$version.jar"
				echo "Successfully installed Distant Horizons for $version"
			else
				echo "Error: Could not find Distant Horizons jar in the downloaded artifacts"
				return 1
			fi
		else
			echo "Error: Failed to extract the zip file"
			return 1
		fi
	else
		echo "Error: Failed to download Distant Horizons"
		return 1
	fi
	
	# Cleanup
	rm -f "$zip_file"
	rm -rf temp-dh
}

# Select the mods you wish to disable:
mod0=
mod1=
mod2=
mod3=
mod4=
mod5=

# Check memory and adjust settings before launching
get_memory_settings

# Upgrading Fabulously Optimized
echo "Checking for Fabulously Optimized upgrades..."
cd ..
mcver="$(jq -r '.components[]|select(.cachedName=="Minecraft")|.version' mmc-pack.json)"
if [ -d .minecraft ]; then
	cd .minecraft/
else
	cd minecraft/
fi
"$INST_JAVA" -jar packwiz-installer-bootstrap.jar https://raw.githubusercontent.com/Fabulously-Optimized/fabulously-optimized/main/Packwiz/${mcver}/pack.toml

# Download Distant Horizons if needed
case "$mcver" in
	"1.21")
		get_distant_horizons "1.21"
		;;
	"1.21.1")
		get_distant_horizons "1.21.1"
		;;
	"1.21.3")
		get_distant_horizons "1.21.3"
		;;
	"1.21.4")
		get_distant_horizons "1.21.4"
		;;
	*)
		echo "Note: Distant Horizons is not configured for Minecraft $mcver"
		;;
esac

# Disabling the mods
echo "Disabling mods..."
cd mods
for mod in\
	$mod1.jar\
	$mod2.jar\
	$mod3.jar\
	$mod4.jar\
	$mod5.jar\
	$mod0.jar
do
	mv ${mod} .$(basename ${mod} .jar).jar.disabled
	echo "${mod} disabled successfully!"
done

/**
 * QRCode Model
 */

const { QR_CODE_TYPES } = require('../utils/constants');

module.exports = (sequelize, DataTypes) => {
  const QRCode = sequelize.define('QRCode', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    type: {
      type: DataTypes.ENUM(...Object.values(QR_CODE_TYPES)),
      allowNull: false,
    },
    referenceId: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    qrData: {
      type: DataTypes.TEXT,
      allowNull: false,
    },
    qrImage: {
      type: DataTypes.STRING(500),
      allowNull: true,
    },
    isActive: {
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: true,
    },
    expiresAt: {
      type: DataTypes.DATE,
      allowNull: true,
    },
    scanCount: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0,
    },
    lastScannedAt: {
      type: DataTypes.DATE,
      allowNull: true,
    },
    scannedBy: {
      type: DataTypes.INTEGER,
      allowNull: true,
      references: {
        model: 'users',
        key: 'id',
      },
    },
    metadata: {
      type: DataTypes.JSON,
      allowNull: true,
      defaultValue: {},
    },
  }, {
    tableName: 'qr_codes',
    timestamps: true,
    underscored: true,
    indexes: [
      {
        fields: ['type', 'reference_id']
      },
      {
        fields: ['is_active']
      },
      {
        fields: ['expires_at']
      }
    ]
  });

  // Instance methods
  QRCode.prototype.isExpired = function() {
    if (!this.expiresAt) return false;
    return new Date() > new Date(this.expiresAt);
  };

  QRCode.prototype.scan = function(userId = null) {
    this.scanCount += 1;
    this.lastScannedAt = new Date();
    if (userId) this.scannedBy = userId;
    return this.save();
  };

  // Define associations
  QRCode.associate = function(models) {
    QRCode.belongsTo(models.User, {
      foreignKey: 'scannedBy',
      as: 'scanner'
    });
  };

  return QRCode;
};
